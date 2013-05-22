source 'http://rubygems.org'

ruby '2.0.0'
gem 'rails', '3.2.13'

group :development do
  # http://documentcloud.github.com/jammit/
  gem 'jammit'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'pry-rails'
end

# Gems used only for assets and not required
# in production environments by default.

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'rails-backbone'
  gem 'compass-rails'
  gem 'bootstrap-sass'
  gem 'bootstrap-datepicker-rails'
  gem 'select2-rails'
  gem 'underscore-rails'
end

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
  gem 'minitest'
  gem 'rspec-rails'
  gem 'database_cleaner'
  gem 'cucumber-rails'
  gem 'capybara-webkit'
  gem 'factory_girl_rails'
end

# debugging tools
group :development, :test do
  gem 'rake'
end

gem 'jquery-rails', '=2.1.4'
gem 'simple_form'

# MongoDB adapter and an optimizer for MongoDB
gem 'mongoid', '~> 3.0.0'
gem 'bson_ext'

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
gem 'puma'
#gem 'thin'

# scaling
gem 'hirefireapp'

# Lists for Mongoid
gem 'acts_as_list_mongoid'

# API templates
gem 'rabl'

# templates
gem 'haml-rails'
gem 'haml_coffee_assets'
gem 'eco'
gem 'mustache-trimmer', :git => 'https://github.com/josh/mustache-trimmer.git'

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

# Gem to access to Facebook graph
gem 'koala'

# Additional features for text searching with mongoid
gem 'mongoid_fulltext'
