class Webviews::ComparisonsController < Webviews::ApplicationController
  
  def index
    # election
    if params[:electionId].blank?
      return render text: "params electionId can't be blank"
    end
    begin
      @election = Election.find params[:electionId]
    rescue Mongoid::Errors::DocumentNotFound
      return render text: "invalid electionId"
    end
    
    # candidates
    if params[:candidacyIds].blank?
      return render text: "params candidacyIds can't be blank"
    end
    begin
      @candidacies = Candidacy.find params[:candidacyIds].split(',')
    rescue Mongoid::Errors::DocumentNotFound
      return render text: "invalid candidacyIds"
    end
    
    # tag
    if params[:tagId].blank?
      return render text: "params tagId can't be blank"
    end
    begin
      @tag = Tag.find params[:tagId]
    rescue Mongoid::Errors::DocumentNotFound
      return render text: "invalid tagId"
    end
    
    # election tag
    @election_tag = ElectionTag.first conditions: {election_id: @election.id, tag_id: @tag.id}
    return render text: "empty" unless @election_tag
    
    conditions = {}
    conditions[:tag_ids.in] = params[:tagId].split(',') unless params[:tagId].blank?
    conditions[:candidacy_id.in] = params[:candidacyIds].split(',') unless params[:candidacyIds].blank?
    
    propositions = Proposition.where(conditions)
    
    @tags_propositions = {}
    propositions.each do |proposition|
      proposition.tag_ids.each do |tag_id|
        @tags_propositions[tag_id.to_s] = [] unless @tags_propositions[tag_id.to_s]
        @tags_propositions[tag_id.to_s] << proposition
      end
    end    
  end
  
end