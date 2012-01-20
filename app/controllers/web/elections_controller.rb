class Web::ElectionsController < Web::ApplicationController
  
  before_filter :set_election
  
  def show
    respond_to do |format|
      format.html do
        @options = render_to_string('/api/v1/elections/show.json', layout: false)
        render "web/application/index", layout: false
      end
    end
  end
  
end