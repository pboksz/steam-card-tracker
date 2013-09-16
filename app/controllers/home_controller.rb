# encoding: utf-8

class HomeController < ApplicationController
  before_filter :load_games

  def index
    @game_items = {}
    query_base = params[:type] == 'booster' ? 'booster' : 'trading+card'

    params[:games].try(:each) do |game_name|
      @game = Game.where(:name => game_name).first_or_create

      query = "#{query_base}+#{@game.query_name}"
      listings_response = Weary::Request.new("http://steamcommunity.com/market/search/render/?query=#{query}&start=0&count=10000").perform
      listings_json = JSON.parse(listings_response.body)

      if listings_json['success']
        @items = []

        listings_html = Nokogiri::HTML(listings_json['results_html'])
        listings_html.css('.market_listing_row_link').each do |listing_html|
          attrs = parse_listing(listing_html)
          @item = update_item(@game, attrs[:current_price], attrs[:item])
          update_daily_stats(@item, attrs[:current_price], attrs[:stats])

          @items << @item
        end

        @game_items.merge!(@game.name => @items)
      end
    end
  end

  private

  def load_games
    @games = Game.all.map(&:name)
  end

  def parse_listing(listing_html)
    attrs = { :item => {}, :stats => {} }

    min_price_string = listing_html.css('.market_listing_row .market_listing_num_listings span').first.children.last.content.squish
    attrs[:current_price] = min_price_string.match(/\d+.\d{1,2}/).to_s.to_f

    name = listing_html.css('.market_listing_row .market_listing_item_name').first.content
    attrs[:item][:name] = name
    attrs[:item][:foil] = name.include?('Foil')
    attrs[:item][:link_url] = listing_html.attributes['href'].value
    attrs[:item][:image_url] = listing_html.css('.market_listing_row img').first.attributes['src'].value
    attrs[:item][:currency_symbol] = min_price_string[0]

    attrs[:stats][:quantity] = listing_html.css('.market_listing_row .market_listing_num_listings .market_listing_num_listings_qty').first.content.gsub!(',', '').to_i

    attrs
  end


  def update_item(game, current_price, attrs)
    item = game.items.where(attrs).first_or_create
    item.current_price = current_price

    item
  end

  def update_daily_stats(item, current_price, attrs)
    stats = item.daily_stats.where(:created_at => Time.now.beginning_of_day..Time.now.end_of_day).first_or_initialize

    stats.quantity_low = attrs[:quantity] if attrs[:quantity] < stats.quantity_low || stats.quantity_low == 0
    stats.quantity_high = attrs[:quantity] if attrs[:quantity] > stats.quantity_high
    stats.min_price_low = current_price if current_price < stats.min_price_low || stats.min_price_low == 0
    stats.min_price_high = current_price if current_price > stats.min_price_high
    stats.save

    stats
  end
end
