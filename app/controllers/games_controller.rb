# encoding: utf-8

class GamesController < ApplicationController
  def index
    @games = Game.all.order(:name)
    render :json => @games.as_json(:only => [:id, :name])
  end

  def show
    @game = Game.find(params[:id])
    regular_items = []
    foil_items = []

    query = "trading+card+#{@game.query_name}"
    listings_response = Weary::Request.new("http://steamcommunity.com/market/search/render/?query=#{query}&start=0&count=2000").perform
    listings_json = JSON.parse(listings_response.body)

    if listings_json['success']
      parse_listings(Nokogiri::HTML(listings_json['results_html'])).each do |attributes|
        # validate card is from the correct game
        if attributes[:game_name] =~ /#{@game.name}\s*(foil\s)?(trading card)/i
          item = @game.items.where(:name => attributes[:name]).first_or_initialize.tap do |item|
            item.all_time_low_price = attributes[:price] if attributes[:price] < item.all_time_low_price || item.all_time_low_price == 0
            item.all_time_high_price = attributes[:price] if attributes[:price] > item.all_time_high_price || item.all_time_high_price == 0
            item.save if item.changed?

            item.current_price = attributes[:price]
            item.current_quantity = attributes[:quantity]
            item.link_url = attributes[:link_url]
            item.image_url = attributes[:image_url]
            item.update_daily_stats
          end

          if item.foil? then foil_items << item else regular_items << item end
        end
      end
    end

    options = { :only => [], :methods => [:short_name, :current_price, :current_quantity, :link_url, :image_url, :all_time_low_price, :all_time_high_price] }

    render :json => {
      :id => @game.id, :name => @game.name,
      :regular_items => regular_items.as_json(options),
      :regular_dates => @game.series_dates(:foil => false),
      :regular_data => @game.series_data(:foil => false),
      :foil_items => foil_items.as_json(options),
      :foil_dates => @game.series_dates(:foil => true),
      :foil_data => @game.series_data(:foil => true)
    }
  rescue
    render :json => { :error => true }
  end

  private

  def parse_listings(listings_html)
    listings = []
    listings_html.css('.market_listing_row_link').each do |listing_html|
      listing = { :item => {} }

      listing[:game_name] = listing_html.css('.market_listing_row .market_listing_game_name').first.content
      listing[:name] = listing_html.css('.market_listing_row .market_listing_item_name').first.content
      listing[:price] = listing_html.css('.market_listing_row .market_listing_num_listings span').first.children.last.content.squish.match(/\d+.\d{1,2}/).to_s.to_f
      listing[:quantity] = listing_html.css('.market_listing_row .market_listing_num_listings .market_listing_num_listings_qty').first.content.gsub(',', '').to_i
      listing[:link_url] = listing_html.attributes['href'].value
      listing[:image_url] = listing_html.css('.market_listing_row img').first.attributes['src'].value

      listings << listing
    end

    listings
  end
end
