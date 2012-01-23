class Embed::ElectionsController < ApplicationController
  
  layout false
  
  def show
    begin
      @election = Election.find params[:id]
    rescue Mongoid::Errors::DocumentNotFound
      return render text: "invalid electionId"
    end
  end
  
end