class StatProcessor
  attr_reader :stats, :listing

  def initialize(stats, listing)
    @stats = stats
    @listing = listing
  end

  def process
    stats_repository.update_prices_for_today(listing.price, listing.quantity)
  end

  private

  def stats_repository
    @stats_repository ||= StatsRepository.new(stats)
  end
end
