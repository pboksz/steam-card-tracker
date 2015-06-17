ruby '2.2.0'
source 'https://rubygems.org'

gem 'rails', '4.0.0'

# Use mongodb
gem 'mongoid', '~> 4.0.0'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'
gem 'font-awesome-sass'
gem 'compass-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Use haml for views
gem 'haml-rails'

# Use highcharts for charts
gem 'highcharts-rails'

gem 'json'
gem 'nokogiri'
gem 'weary'

group :test do
  gem 'codeclimate-test-reporter', require: nil
  gem 'database_cleaner'
end

group :development, :test do
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'factory_girl_rails'
  gem 'quiet_assets'
  gem 'pry'
  gem 'rspec-rails'
  gem 'travis'
end

group :development, :production do
  gem 'unicorn'
end

group :production do
  gem 'heroku-deflater'
  gem 'rails_12factor'
end
