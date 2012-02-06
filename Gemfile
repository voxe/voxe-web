source 'http://rubygems.org'

gem 'rails', '3.1.3'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

# gem 'sqlite3'

group :development do
  # http://documentcloud.github.com/jammit/
  gem 'jammit'
end

# Gems used only for assets and not required
# in production environments by default.

group :assets do
  gem 'sass-rails',   '~> 3.1.5'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

group :test do
  # Pretty printed test output
  gem 'turn', :require => false

  gem 'minitest'
end

group :development do
  gem "haml-rails"
  gem 'factory_girl_rails'
end

group :test do
  gem 'rspec-rails'
  gem 'database_cleaner'
  gem 'cucumber-rails'
  gem 'capybara-webkit'
  gem 'factory_girl_rails'
end

# debugging tools
group :development, :test do
  gem 'pry-rails'
end

gem 'jquery-rails'

# MongoDB adapter and an optimizer for MongoDB
# gem "mongoid", "~> 2.3"
# gem "bson_ext", "~> 1.4"
gem "mongoid"
gem "bson_ext"

# Upload system
gem 'carrierwave'

# S3 gem for carrierwave
gem 'fog'

# Send assets to S3
gem 'asset_sync'

# Mongoid for carrierwave
gem 'carrierwave-mongoid', :require => 'carrierwave/mongoid'

# Rmagick for carrierwave
gem 'mini_magick'

# User authentication
gem 'devise'

# User authorization
gem 'cancan'

# Webserver
# http://michaelvanrooijen.com/articles/2011/06/01-more-concurrency-on-a-single-heroku-dyno-with-the-new-celadon-cedar-stack/
gem 'unicorn'

# scaling
gem 'hirefireapp'

# Lists for Mongoid
gem 'acts_as_list_mongoid'

# API templates
gem 'rabl'

# templates
gem 'haml'
gem 'coffee-filter'
gem 'haml_coffee_assets'
gem 'eco'
gem 'haml-coffee'

# http://voxe.airbrake.io/
gem "airbrake"

# URL parser to checkout embed code
gem 'ruby-oembed'

# configuration for different env.
gem "settingslogic"

# New relic to track our performances
gem 'newrelic_rpm'

# Caching with Memcache
gem 'dalli'

# templating markup
gem 'rdiscount'