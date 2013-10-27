# encoding: UTF-8
class Backoffice::PropositionsController < Backoffice::BackofficeController
  before_filter :load_profile
  before_filter :load_candidacy
  before_filter :load_election
  # load_and_authorize_resource :election, :proposition
  before_filter :load_proposition, :only => [:edit, :update, :destroy]
  before_filter :load_proposition_tags, :only => [:edit]

  def index
    if (params[:namespace_categ])
      @active_tag = @candidacy.election.election_tags.select{ |election_tag| election_tag.tag.namespace == params[:namespace_categ] }.first
      @propositions_categ = @candidacy.propositions.select{ |proposition| proposition.tag_ids.include?(@active_tag.tag_id) }
    else
      @active_tag = nil
      @propositions_categ = []
    end
    @lst_tags = @candidacy.election.election_tags.where(:parent_tag_id => nil)

  end

  def new
    gon.page = "new"
    @proposition = Proposition.new
    @tags = @candidacy.election.election_tags.find(params[:election_tag_id]).children_election_tags.map &:tag
  end

  def create
    params[:proposition][:tag_ids].delete("")
    @proposition = @candidacy.propositions.build(params[:proposition])
    election_tag = @candidacy.election.election_tags.find(params[:election_tag_id])
    @tags = election_tag.children_election_tags.map &:tag
    if @proposition.save
      redirect_to backoffice_propositions_path(namespace_categ: election_tag.tag.namespace)
    else
      render action: :new
    end
  end

  def show
    redirect_to action: :edit
  end

  def edit
    gon.page = "edit"
    gon.proposition_tags = @proposition_tags.map{ |tag| tag._id }
  end

  def update
    params[:proposition][:tag_ids].delete("") if params[:proposition] and params[:proposition][:tag_ids].present?
    if @proposition.update_attributes params[:proposition]
      redirect_to backoffice_propositions_path, notice: 'Votre proposition a été mis à jour'
    else
      load_proposition_tags
      gon.proposition_tags = @proposition_tags.map{ |tag| tag._id }
      render action: :edit
    end
  end

  def destroy
    @proposition.destroy
    redirect_to :back
  end

  protected

  def load_proposition
    @proposition ||= Proposition.where(:_id => params[:id]).first
  end

  def load_proposition_tags
    @proposition_tags ||= @proposition.tag_ids.map { |tag_id| Tag.where(:_id => tag_id).first}
  end

end
