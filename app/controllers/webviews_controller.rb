class WebviewsController < ApplicationController
  
  # touch
  before_filter :set_format
  
  def index
  end
  
  # params electionId, candidacyIds, tagId
  def compare
    # election
    begin
      @election = Election.find params[:electionId]
    rescue Mongoid::Errors::DocumentNotFound
      return render text: "invalid electionId"
    end
    
    # candidates
    begin
      @candidacies = Candidacy.find params[:candidacyIds].split(',')
    rescue Mongoid::Errors::DocumentNotFound
      return render text: "invalid candidacyIds"
    end
    
    # tag
    begin
      @tag = Tag.find params[:tagId]
    rescue Mongoid::Errors::DocumentNotFound
      return render text: "invalid tagId"
    end
    
    # election tag
    @election_tag = ElectionTag.first conditions: {election_id: @election.id, tag_id: @tag.id}
    return render text: "empty" unless @election_tag
    
    conditions = {}
    conditions[:tag_ids.in] = params[:tagIds].split(',') unless params[:tagIds].blank?
    conditions[:candidacy_id.in] = params[:candidacyIds].split(',') unless params[:candidacyIds].blank?
    
    propositions = Proposition.where conditions
                                     
    @tags_propositions = {}
    propositions.each do |proposition|
      proposition.tags.each do |tag|
        @tags_propositions[tag.id.to_s] = [] unless @tags_propositions[tag.id.to_s]
        @tags_propositions[tag.id.to_s] << proposition
      end
    end
  end
  
  def proposition
    begin
      @proposition = Proposition.find params[:propositionId]
    rescue Mongoid::Errors::DocumentNotFound
      return render text: "invalid propositionId"
    end
  end
  
  private
    def set_format
      request.format = :touch
    end
  
end