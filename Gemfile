source 'http://rubygems.org'

ruby '2.2.2'
gem 'rails', '3.2.22'

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
  gem 'autoprefixer-rails'
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

gem 'jquery-rails', '~>2.1.4'
gem 'simple_form'

# MongoDB adapter and an optimizer for MongoDB
gem 'mongoid'
gem 'mongoid_slug'
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
gem "hirefire-resource"

# Lists for Mongoid
gem 'acts_as_list_mongoid'

# API templates
gem 'rabl'

# templates
gem 'haml-rails'
gem 'haml_coffee_assets'
gem 'eco'
gem 'mustache-trimmer-rails'
gem 'simple_form'
gem 'select2-rails'

# http://voxe.airbrake.io/
gem "airbrake"

# URL parser to checkout embed code
gem 'ruby-oembed'

# configuration for different env.
gem "settingslogic"

# New relic to track our performances
gem 'newrelic_rpm'

# Caching with Memcache
gem 'memcachier'
gem 'dalli'

# templating markup
gem 'rdiscount'

# Gem to access to Facebook graph
gem 'koala'

# Additional features for text searching with mongoid
gem 'mongoid_fulltext'

# Internationalization according to http accept-language
gem 'http_accept_language'

# Gem to get rails variables in js
gem 'gon'

# Add a type for geospcial stuff on mongoid
gem 'mongoid_spacial'

# Geocode ip addresses, etc...
gem 'geocoder', require: false

# Pagination
gem 'will_paginate_mongoid'

# It needs it, I don't why and I'm tired...
gem 'test-unit'
