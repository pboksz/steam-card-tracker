class ItemJsonGenerator
  attr_reader :item

  def initialize(item)
    @item = item
  end

  def generate
    {
      name: item.name,
      link_url: item.link_url,
      image_url: item.image_url,
      latest_price: item.latest_price,
      latest_quantity: item.latest_quantity,
      all_time_min_price_low: item.all_time_min_price_low,
      all_time_min_price_high: item.all_time_min_price_high
    }
  end

  def generate_data
    {
      name: item.name,
      data: item.all_stats_data
    }
  end
end
