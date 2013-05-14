class Backoffice::PropositionsController < Backoffice::BackofficeController
  load_and_authorize_resource :election, :proposition
  before_filter :load_proposition, :only => [:edit]
  load_and_authorize_resource :candidacy
  before_filter :load_tags, :only => [:new, :edit]
  before_filter :load_proposition_tags, :only => [:edit]

  def index
    @propositions = current_candidacy.propositions
  end

  def new
    @proposition = Proposition.new
  end

  def create
    @proposition = current_candidacy.propositions.create(params[:proposition])
    respond_with @proposition, location: backoffice_proposition_path(@proposition[:_id])
  end

  def show
    redirect_to action: :edit
  end

  def edit
  end

  def update
    @proposition.update_attributes params[:proposition]
    respond_with @proposition, location: backoffice_propositions_path(@proposition[:_id])
  end

  protected

  def load_tags
    @tags ||= current_candidacy.election.election_tags.select{ |elt| !elt.root? }.map { |elt| elt.tag }
  end

  def load_proposition
    @proposition ||= Proposition.where(:_id => params[:id]).first
  end

  def load_proposition_tags
    @proposition_tags ||= @proposition.tag_ids.map { |tag_id| Tag.where(:_id => tag_id).first}
  end

end
