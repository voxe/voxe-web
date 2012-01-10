class Touch::ElectionsController < Touch::ApplicationController
  
  before_filter :set_election, except: :index
  
  def index
    @elections = Election.all
  end
  
  def show
    respond_to do |format|
      format.touch do
        @json = render_to_string('/api/v1/elections/show.json', layout: false)
      end
    end
  end
  
end