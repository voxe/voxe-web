class Web::CountriesController < Web::ApplicationController

  # will be reset every deploy
  caches_action :show
  
  def show
    respond_to do |format|
      format.html do
        @elections = Election.where(published: true)
        @only_published_candidacies = true
        @options = render_to_string('/api/v1/elections/search.json', layout: false)
        render "web/application/index"
      end
    end
  end
  
end
