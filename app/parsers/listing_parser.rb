class ListingParser
  attr_reader :listing

  def initialize(listing)
    @listing = listing
  end

  def item_name
    asset['name']
  end

  def game_name
    asset['type'].tr('™', '').tr('®', '')
  end

  def link_url
    File.join('https://steamcommunity.com/market/listings', asset['appid'].to_s, asset['market_hash_name'].to_s)
  end

  def image_url
    File.join('https://community.cloudflare.steamstatic.com/economy/image', asset['icon_url'].to_s)
  end

  def quantity
    listing['sell_listings'].to_i
  end

  def price
    listing['sell_price'].to_f / 100.0
  end

  def available?
    quantity > 0
  end

  def foil?
    item_name.end_with?('(Foil)') || item_name.end_with?("(Foil Trading Card)")
  end

  private

  def asset
    @asset ||= listing['asset_description']
  end
end
