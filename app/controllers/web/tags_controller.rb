class Web::TagsController < Web::ApplicationController
  
  before_filter :set_election
  # will be reset every deploy
  caches_action :index
  
  def index
    respond_to do |format|
      format.html do
        @only_published_candidacies = true
        @all_tags = true
        @options = render_to_string('/api/v1/elections/show.json', layout: false)
        render "web/application/index"
      end
    end
  end
  
end