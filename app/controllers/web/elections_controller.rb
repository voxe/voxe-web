class Web::ElectionsController < Web::ApplicationController
  
  before_filter :set_election
  
  def show
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
