# encoding: utf-8

class GamesController < ApplicationController
  def index
    #@games = Game.all.order(:name)
    @games = Game.limit(2)
    render :json => @games.as_json(:only => [:id, :name])
  end

  def show
    @game = Game.includes(:items => :daily_stats).find(params[:id])
    items = []

    query = "trading+card+#{@game.query_name}"
    listings_response = Weary::Request.new("http://steamcommunity.com/market/search/render/?query=#{query}&start=0&count=2000").perform
    listings_json = JSON.parse(listings_response.body)

    if listings_json['success']
      parse_listings(Nokogiri::HTML(listings_json['results_html'])).each do |attributes|
        # validate card is from the correct game
        if attributes[:game_name] =~ /#{@game.name}\s*(foil\s)?(trading card)/i
          items << @game.items.where(attributes[:item]).first_or_create.tap do |item|
            item.current_price = attributes[:price]
            item.current_quantity = attributes[:quantity]
            item.update_daily_stats
          end
        end
      end
    end

    items_json = items.as_json(
      :only => [:link_url, :image_url, :foil, :currency_symbol],
      :methods => [:short_name, :current_price, :current_quantity, :all_time_low_price, :all_time_high_price]
    )

    render :json => { :id => @game.id, :name => @game.name, :items => items_json,
                      :series_dates => @game.series_dates, :series_data => @game.series_data }
  end

  private

  def parse_listings(listings_html)
    listings = []
    listings_html.css('.market_listing_row_link').each do |listing_html|
      listing = { :item => {} }

      listing[:game_name] = listing_html.css('.market_listing_row .market_listing_game_name').first.content
      listing[:price] = listing_html.css('.market_listing_row .market_listing_num_listings span').first.children.last.content.squish.match(/\d+.\d{1,2}/).to_s.to_f
      listing[:quantity] = listing_html.css('.market_listing_row .market_listing_num_listings .market_listing_num_listings_qty').first.content.gsub(',', '').to_i

      listing[:item][:name] = listing_html.css('.market_listing_row .market_listing_item_name').first.content
      listing[:item][:foil] = listing[:item][:name].include?('Foil')
      listing[:item][:link_url] = listing_html.attributes['href'].value
      listing[:item][:image_url] = listing_html.css('.market_listing_row img').first.attributes['src'].value

      listings << listing
    end

    listings
  end
end
