class Mobile::ElectionsController < Mobile::ApplicationController
  
  before_filter :set_election, except: :index
  
  def index
    @elections = Election.all
  end
  
  def show
  end
  
  def compare
    # candidacies
    begin
      @candidacies = Candidacy.find params[:candidacies].split(',')
    rescue
      return render text: "invalid candidacies"
    end
    
    # tag
    begin
      @tag = Tag.first conditions: {namespace: params[:tag]}
    rescue
      return render text: "invalid tag"
    end
    
    # election tag
    @election_tag = ElectionTag.first conditions: {election_id: @election.id, tag_id: @tag.id}
    return render text: "empty" unless @election_tag
        
    propositions = Proposition.where :candidacy_id.in => @candidacies.collect(&:id),
                                     :tag_ids => @tag.id
                                     
    @tags_propositions = {}
    propositions.each do |proposition|
      proposition.tags.each do |tag|
        @tags_propositions[tag.id.to_s] = [] unless @tags_propositions[tag.id.to_s]
        @tags_propositions[tag.id.to_s] << proposition
      end
    end
  end
  
end