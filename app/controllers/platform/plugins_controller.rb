class Platform::PluginsController < ApplicationController
  
  layout 'platform'
  
  def index
  end
  
  def button
  end
  
  def bookmarklet
    @election = Election.first
  end
  
end