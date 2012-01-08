class Plugins::CompareController < ApplicationController
  
  layout false
  
  def index
    begin
      @election = Election.find params[:id]
    rescue Mongoid::Errors::DocumentNotFound
      return render text: "invalid electionId"
    end
  end
  
end