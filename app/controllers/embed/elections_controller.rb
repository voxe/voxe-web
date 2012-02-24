class Embed::ElectionsController < ApplicationController
  
  layout false
  
  # will be reset every deploy
  caches_action :show
  
  def show
    begin
      @election = Election.find params[:id]
    rescue Mongoid::Errors::DocumentNotFound
      return render text: "invalid electionId"
    end
  end
  
end