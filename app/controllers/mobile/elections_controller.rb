class Mobile::ElectionsController < Mobile::ApplicationController
  
  before_filter :set_election, except: :index
  
  def index
    @elections = Election.where published: true
  end
  
  def show
    @page_title = "#{@election.name}"
  end
  
  def compare
    # candidacies
    begin
      @candidacies = @election.candidacies.select do |candidacy|
        params[:candidacies].split(',').include? candidacy.namespace
      end
    rescue
      return render text: "invalid candidacies"
    end
    
    # tag
    begin
      @tag = Tag.where({namespace: params[:tag]}).first
    rescue
      return render text: "invalid tag"
    end
    
    # title
    @page_title = @candidacies.collect { |candidacy| candidacy.name }.join(', ')
    @page_title += " - #{@tag.name}"
    @page_title += " | #{@election.name}"
    
    # election tag
    @election_tag = ElectionTag.where({election_id: @election.id, tag_id: @tag.id}).first
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