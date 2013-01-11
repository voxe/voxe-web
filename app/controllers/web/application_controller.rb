class Web::ApplicationController < ApplicationController
  
  # will be reset every deploy
  caches_action :index

  def index
    @options = {}
  end
  
  private
    def set_election
      @only_published_candidacies = true
      @election = Election.where({namespace: params[:namespace]}).first
      # returns 404 if election does not exist
      return not_found unless @election
    end
  
end
