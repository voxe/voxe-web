# encoding: UTF-8
class NewAdmin::PropositionsController < AdminController
  load_and_authorize_resource :election, find_by: :namespace
  load_and_authorize_resource :candidacy
  load_and_authorize_resource :proposition
  before_filter :load_proposition_tags, :only => [:edit]

  def index
    @election_name = @candidacy.election.name
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
    load_select_tag
  end

  def create
    params[:proposition][:tag_ids].delete("")
    @proposition = @candidacy.propositions.build(params[:proposition])
    election_tag = @candidacy.election.election_tags.find(params[:election_tag_id])
    @tags = election_tag.children_election_tags.map &:tag
    @proposition.updated_by = current_user
    if @proposition.save
      flash[:notice] = 'Votre proposition a été ajoutée'
      redirect_to new_admin_election_candidacy_propositions_path(@election, @candidacy, namespace_categ: election_tag.tag.namespace)
    else
      flash[:error] = 'Une erreur est survenue lors de la création de votre proposition. Veuillez réessayer et veillez à bien remplir les champs ci-dessous'
      redirect_to :back
    end
  end

  def show
    redirect_to action: :edit
  end

  def edit
    @tags = @candidacy.election.election_tags.where(parent_tag_id: nil, :tag.in =>  @proposition.tag_ids).first.children_election_tags.map &:tag
    gon.page = "edit"
    gon.proposition_tags = @proposition_tags.map{ |tag| tag._id }
    load_select_tag
  end

  def update
    params[:proposition][:tag_ids].delete("") if params[:proposition] and params[:proposition][:tag_ids].present?
    @proposition.updated_by = current_user
    if @proposition.update_attributes params[:proposition]
      flash[:notice] = "Votre proposition a été mis à jour"
      election_tag = @candidacy.election.election_tags.find(params[:election_tag_id])
      redirect_to new_admin_election_candidacy_propositions_path(namespace_categ: election_tag.tag.namespace)
    else
      load_proposition_tags
      gon.proposition_tags = @proposition_tags.map{ |tag| tag._id }
      flash[:error] = 'Une erreur est survenue lors de la mise à jour de votre proposition. Veuillez réessayer et veillez à bien remplir les champs ci-dessous'
      redirect_to :back
    end
  end

  def destroy
    @proposition.destroy
    redirect_to :back
  end

  protected

  def load_select_tag
    @election_tags = @candidacy.election.election_tags.where("parent_tag_id" => nil).sort_by{ |t| t.tag.name }
    
    @tags = Array.new
      i = 0
      @election_tags.each do |t|
        @tags[i] = t.children_election_tags.map &:tag
        @stock = i if t.id.to_s == params[:election_tag_id]
        i += 1
      end
  end

  def load_proposition
    @proposition ||= Proposition.where(:_id => params[:id]).first
  end

  def load_proposition_tags
    @proposition_tags ||= @proposition.tag_ids.map { |tag_id| Tag.where(:_id => tag_id).first}
  end

end
