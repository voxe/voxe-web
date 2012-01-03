class Plugins::CompareController < ApplicationController
  
  layout false
  
  def index
    @election = Election.find params[:id]
  end
  
end