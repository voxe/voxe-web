class Backoffice::PropositionsController < Backoffice::BackofficeController
  load_and_authorize_resource :election, :proposition
  before_filter :load_proposition, :only => [:edit, :update]
  load_and_authorize_resource :candidacy

  helper_method :load_tags, :load_proposition_tags

  def index
    @propositions = current_candidacy.propositions
  end

  def new
    @proposition = Proposition.new
  end

  def create
    @proposition = Proposition.create(:candidacy => current_candidacy)
    #@proposition.update_attributes params[:proposition]
    respond_with @proposition, location: backoffice_proposition_path(@proposition[:_id])
  end

  def show
    redirect_to action: :edit
  end

  def edit
    load_tags
  end

  def update
    @proposition.update_attributes params[:proposition]
    respond_with @proposition, location: backoffice_propositions_path(@proposition[:_id])
  end

  protected

  def load_tags
    @tags = Array.new
    current_candidacy.election.election_tags.each do |election_tag|
      if !election_tag.root?
        @tags << election_tag.tag
      end
    end
  end

  def load_proposition
    @proposition ||= Proposition.where(:_id => params[:id]).first
  end

  def load_proposition_tags
    @proposition_tags = []
    @proposition.tag_ids.each do |tag_id|
      @proposition_tags << Tag.where(:_id => tag_id).first
    end
  end

end
