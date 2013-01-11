class Mobile::ApplicationController < ApplicationController
  
  private
    def set_election
      @election = Election.where({namespace: params[:namespace]}).first
      # returns 404 if election does not exist
      return not_found unless @election
    end
    
end
