ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase

  teardown :clean_mongodb
  def clean_mongodb
    # Mongoid.master.collections.select {|c| c.name !~ /system/ }.each(&:drop)
    DatabaseCleaner.clean
  end

end

class ActionController::TestCase
  include Devise::TestHelpers
end
