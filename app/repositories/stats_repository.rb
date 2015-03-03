class StatsRepository < DefaultRepository
  def update_prices_for_today(price)
    stats = find_or_initialize(created_at: Time.now.beginning_of_day..Time.now.end_of_day)
    stats.min_price_low = price if price < stats.min_price_low || stats.min_price_low == 0
    stats.min_price_high = price if price > stats.min_price_high || stats.min_price_high == 0
    stats.save if stats.changed?

    stats
  end
end
