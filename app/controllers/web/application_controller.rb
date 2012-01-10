class Web::ApplicationController < ApplicationController
  
  private
    def set_election
      @election = Election.first conditions: {namespace: params[:election_namespace]}
      # returns 404 if election does not exist
      return not_found unless @election
    end
  
end