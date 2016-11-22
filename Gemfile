ruby '2.2.5'
source 'https://rubygems.org'

gem 'rails', '~> 4.1.16'
gem 'mongoid', '~> 4.0.0'

gem 'sass-rails', '~> 4.0.0'
gem 'font-awesome-sass'
gem 'compass-rails'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'therubyracer', platforms: :ruby

gem 'jquery-rails'
gem 'haml-rails'
gem 'highcharts-rails'
gem 'json'
gem 'nokogiri'
gem 'weary'
gem 'admin_auth'

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
