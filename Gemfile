ruby '2.4.2'
source 'https://rubygems.org'

gem 'rails', '~> 4.2.7'
gem 'mongoid', '~> 5.4.1'

gem 'sass-rails'
gem 'font-awesome-sass'
gem 'compass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'haml-rails'
gem 'highcharts-rails'
gem 'json'
gem 'weary'
gem 'admin_auth'

group :test do
  gem 'database_cleaner'
end

group :development, :test do
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
