# encoding: utf-8

class HomeController < ApplicationController
  before_filter :init_games

  def index
    @game_listings = {}

    params[:games].try(:each) do |game|
      query = "trading+card+#{game.downcase.gsub(' ', '+')}"
      listings_response = Weary::Request.new("http://steamcommunity.com/market/search/render/?query=#{query}&start=0&count=10000").perform
      listings_json = JSON.parse(listings_response.body)

      if listings_json['success']
        listings = []

        listings_html = Nokogiri::HTML(listings_json['results_html'])
        listings_html.css('.market_listing_row_link').each do |listing_html|
          listing = parse_listing(listing_html)
          if params[:foil]
            listings << listing if listing.foil?
          else
            listings << listing if !listing.foil?
          end
        end

        @game_listings.merge!(game => listings)
      end
    end
  end

  private

  def init_games
    @games = ['Dota 2', 'Brütal Legend', 'Trine 2']
  end

  def parse_listing(listing)
    params = {}
    params[:link] = listing.attributes['href'].value
    params[:image] = listing.css('.market_listing_row img').first.attributes['src'].value
    params[:quantity] = listing.css('.market_listing_row .market_listing_num_listings .market_listing_num_listings_qty').first.content
    params[:min_price] = listing.css('.market_listing_row .market_listing_num_listings span').first.children.last.content.squish
    params[:name] = listing.css('.market_listing_row .market_listing_item_name').first.content

    Listing.new(params)
  end

  class Listing
    attr_accessor :link, :image, :quantity, :min_price, :name

    def initialize(params)
      @link = params[:link]
      @image = params[:image]
      @quantity = params[:quantity]
      @min_price = params[:min_price]
      @name = params[:name]
    end

    def foil?
      @name.include?('Foil')
    end
  end
end
