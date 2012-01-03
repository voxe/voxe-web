class PluginsController < ApplicationController
  
  layout false
  
  def index
  end
  
  def demo
    @election = Election.first
  end
  
end