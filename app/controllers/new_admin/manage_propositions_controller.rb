class NewAdmin::ManagePropositionsController < AdminController
  before_filter :load_propositions

  def index
  end

  private

  def load_propositions
    @propositions = Proposition.desc(:updated_at).limit(30)
    authorize! :manage, @propositions
  end
end
