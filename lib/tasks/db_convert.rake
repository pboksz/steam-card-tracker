namespace :db do
  desc "convert from mysql db to mango db"
  task :mysql_to_mongo => :environment do
    mysql_options = {
      :database => ENV["MYSQL_DB_NAME"],
      :username => ENV["MYSQL_DB_USERNAME"],
      :password => ENV["MYSQL_DB_PASSWORD"],
      :host =>     ENV["MYSQL_DB_HOST"]
    }
    mysql_db = Mysql2::Client.new(mysql_options)

    mysql_db.query("SELECT * FROM games ORDER BY name").each do |sql_game|
      game = Game.where(:name => sql_game["name"]).first_or_initialize.tap do |game|
        game.created_at = sql_game["created_at"]
        game.save if game.changed?

        puts "Added game: #{game.name}"
      end

      mysql_db.query("SELECT * FROM items WHERE game_id = #{sql_game["id"]}").each do |sql_item|
        item = game.items.where(:name => sql_item["name"]).first_or_initialize.tap do |item|
          item.created_at = sql_item["created_at"]
          item.save if item.changed?

          puts "\tAdded item: #{item.name}"
        end

        mysql_db.query("SELECT * FROM daily_stats WHERE item_id = #{sql_item["id"]}").each do |sql_stat|
          item.stats.where(:created_at => sql_stat["created_at"].to_datetime.beginning_of_day..sql_stat["created_at"].to_datetime.end_of_day).first_or_initialize.tap do |stat|
            stat.min_price_low = sql_stat["min_price_low_integer"] / 100.00
            stat.min_price_high = sql_stat["min_price_high_integer"] / 100.00
            stat.created_at = sql_stat["created_at"]
            stat.save if stat.changed?

            puts "\t\tAdded stat for #{stat.created_at.to_s(:db)}"
          end
        end
      end
    end
  end
end
