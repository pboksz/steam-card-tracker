namespace :all_time_prices do
  desc "migrate all time prices from daily stats minimums and maximums"
  task :migrate => :environment do
    puts "Starting migration of all time low and high prices"
    Item.all.each do |item|
      item.all_time_low_price = item.daily_stats.minimum(:min_price_low_integer).try(:/, 100.00) || 0
      item.all_time_high_price = item.daily_stats.maximum(:min_price_high_integer).try(:/, 100.00) || 0
      item.save if item.changed?

      puts "#{item.name}: low = #{item.all_time_low_price}, high = #{item.all_time_high_price}"
    end
  end
end
