class NewAdmin::ManagePropositionsController < AdminController
  before_filter :load_propositions

  def index
  end

  private

  def load_propositions
    @propositions = Proposition.desc(:updated_at).paginate(:page => params[:proposition], :per_page => 30)
    authorize! :manage, @propositions
  end

  
end
