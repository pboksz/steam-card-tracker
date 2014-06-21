# encoding: utf-8

class GamesController < ApplicationController
  def index
    @games = Game.all
    render :json => @games.as_json
  end

  def show
    @game = Game.find(params[:id])

    query = "trading+card+#{@game.query_name}"
    listings_response = Weary::Request.new("http://steamcommunity.com/market/search/render/?query=#{query}&start=0&count=2000").perform
    listings_json = JSON.parse(listings_response.body)

    if listings_json['success'] && listings_json['total_count'] > 0
      parse_listings(Nokogiri::HTML(listings_json['results_html'])).each do |attributes|
        # validate card is from the correct game
        if attributes[:game_name] =~ /#{Regexp.escape(@game.name)}\s*(foil\s)?(trading card)/i
          @game.items.where(:name => attributes[:name]).first_or_create.tap do |item|
            item.link_url = attributes[:link_url]
            item.image_url = attributes[:image_url]
            item.stats.where(:created_at => Time.now.beginning_of_day..Time.now.end_of_day).first_or_initialize.tap do |stat|
              stat.min_price_low = attributes[:price] if attributes[:price] < stat.min_price_low || stat.min_price_low == 0
              stat.min_price_high = attributes[:price] if attributes[:price] > stat.min_price_high || stat.min_price_high == 0
              stat.save if stat.changed?
            end
          end
        end
      end

      render :json => @game.as_json
    else
      render :json => @game.errors, :status => :unprocessable_entity
    end
  end

  def new
    @game = Game.new
  end

  def create
    if @game = Game.create(permitted_params)
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def parse_listings(listings_html)
    listings = []
    listings_html.css('.market_listing_row_link').each do |listing_html|
      listing = {}

      listing[:game_name] = listing_html.css('.market_listing_row .market_listing_game_name').first.content
      listing[:name] = listing_html.css('.market_listing_row .market_listing_item_name').first.content
      listing[:price] = listing_html.css('.market_listing_row .market_table_value span').first.content.match(/\d+.\d{1,2}/).to_s.to_f
      listing[:link_url] = listing_html.attributes['href'].value
      listing[:image_url] = listing_html.css('.market_listing_row img').first.attributes['src'].value

      listings << listing
    end

    listings
  end

  def permitted_params
    params.require(:game).permit(:name)
  end
end
