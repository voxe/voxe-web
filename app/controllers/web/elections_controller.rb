class Web::ElectionsController < Web::ApplicationController
  
  before_filter :set_election, except: :index
  
  def index 
    # @elections = Election.all
    # redirect_to @elections.first
    render 'v2'
  end
  
  def show
    return redirect_to root_path
    respond_to do |format|
      format.html do
        @json = render_to_string('/api/v1/elections/show.json', layout: false)
      end
    end
  end
  
  # def compare
  #   # candidacies
  #   begin
  #     @candidacies = Candidacy.find params[:candidacyIds].split(',')
  #   rescue Mongoid::Errors::DocumentNotFound
  #     return render text: "invalid candidacyIds"
  #   end
  #   
  #   # tag
  #   begin
  #     @tag = Tag.find params[:tagId]
  #   rescue Mongoid::Errors::DocumentNotFound
  #     return render text: "invalid tagId"
  #   end
  #   
  #   # election tag
  #   @election_tag = ElectionTag.first conditions: {election_id: @election.id, tag_id: @tag.id}
  #   return render text: "empty" unless @election_tag
  #   
  #   propositions = Proposition.where :candidacy_id.in => params[:candidacyIds].split(','),
  #                                    :tag_ids => params[:tagId]
  #                                    
  #   @tags_propositions = {}
  #   propositions.each do |proposition|
  #     proposition.tags.each do |tag|
  #       @tags_propositions[tag.id.to_s] = [] unless @tags_propositions[tag.id.to_s]
  #       @tags_propositions[tag.id.to_s] << proposition
  #     end
  #   end
  # end
  
end