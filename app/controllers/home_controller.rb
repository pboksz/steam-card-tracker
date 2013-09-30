# encoding: utf-8

class HomeController < ApplicationController
  def index
    @games = Game.all.order(:name)

    @game_items = []
    query_base = params[:type] == 'booster' ? 'booster' : 'trading+card'

    params[:games].try(:each) do |game_name|
      @game = Game.includes(:items).where(:name => game_name).first_or_create

      query = "#{query_base}+#{@game.query_name}"
      listings_response = Weary::Request.new("http://steamcommunity.com/market/search/render/?query=#{query}&start=0&count=2000").perform
      listings_json = JSON.parse(listings_response.body)

      if listings_json['success']
        @items = []

        Nokogiri::HTML(listings_json['results_html']).css('.market_listing_row_link').each do |listing_html|
          attrs = parse_listing(listing_html)

          if attrs[:game_name] =~ /#{@game.name}\s(foil\s)?(trading card)/i
            if params[:type] == 'regular' && attrs[:item][:foil] == false # looking for regular and card is not foil
              @items << update_item(@game, attrs)
            elsif params[:type] == 'foil' && attrs[:item][:foil] == true # looking for foils and card is a foil
              @items << update_item(@game, attrs)
            elsif params[:type] == 'booster' # looking for boosters only
              @items << update_item(@game, attrs)
            end
          end
        end

        @game_items << { :game => { :id => @game.id, :name => @game.name }, :items => @items }
      end
    end
  end

  def update_stats
    game = Game.includes(:items => :daily_stats).find(params[:id])
    dates = []
    series = []

    params[:items].each do |index, info|
      item = game.items.find(info[:id])
      quantity = info[:quantity].to_i
      price = info[:price].to_f

      item.daily_stats.where(:created_at => Time.now.beginning_of_day..Time.now.end_of_day).first_or_initialize.tap do |stats|
        stats.min_price_low = price if price < stats.min_price_low || stats.min_price_low == 0
        stats.min_price_high = price if price > stats.min_price_high
        stats.quantity_low = quantity if quantity < stats.quantity_low || stats.quantity_low == 0
        stats.quantity_high = quantity if quantity > stats.quantity_high
        stats.save if stats.changed?
      end

      dates = item.daily_stats.order(:created_at).map(&:humanize_date) if dates.empty?
      series << { :name => item.short_name, :data => item.daily_stats.order(:created_at).map { |stat| [stat.min_price_low, stat.min_price_high] } }
    end

    render :json => { :success => true, :id => game.id, :dates => dates, :series => series }
  end

  private

  def parse_listing(listing_html)
    attrs = { :item => {} }

    min_price_string = listing_html.css('.market_listing_row .market_listing_num_listings span').first.children.last.content.squish
    attrs[:current_price] = min_price_string.match(/\d+.\d{1,2}/).to_s.to_f
    attrs[:current_quantity] = listing_html.css('.market_listing_row .market_listing_num_listings .market_listing_num_listings_qty').first.content.gsub(',', '').to_i
    attrs[:game_name] = listing_html.css('.market_listing_row .market_listing_game_name').first.content

    name = listing_html.css('.market_listing_row .market_listing_item_name').first.content
    attrs[:item][:name] = name
    attrs[:item][:foil] = name.include?('Foil')
    attrs[:item][:link_url] = listing_html.attributes['href'].value
    attrs[:item][:image_url] = listing_html.css('.market_listing_row img').first.attributes['src'].value
    attrs[:item][:currency_symbol] = min_price_string[0]

    attrs
  end

  def update_item(game, attrs)
    game.items.where(:name => attrs[:item][:name]).first_or_initialize.tap do |item|
      item.assign_attributes(attrs[:item])
      item.save if item.changed?
      item.current_price = attrs[:current_price]
      item.current_quantity = attrs[:current_quantity]
    end
  end
end
