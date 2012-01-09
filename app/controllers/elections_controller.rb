class ElectionsController < ApplicationController
  
  def index 
    @elections = Election.all
  end
  
  def show
    @election = Election.first conditions: {namespace: params[:election_namespace]}
    # returns 404 if election does not exist
    return not_found unless @election
    
    respond_to do |format|
      format.html do
        @json = render_to_string('api/v1/elections/show.json', layout: false)
      end
      format.touch do
        @json = render_to_string('api/v1/elections/show.json', layout: false)
      end
      format.mobile
    end
  end
  
  def tags
    @election   = Election.first conditions: {namespace: params[:election_namespace]}
    # returns 404 if election does not exist
    return not_found unless @election
    
    if params[:candidacies].blank?
      redirect_to @election
    end
    
    unless params[:tagId].blank?
      redirect_to election_compare_path(@election, tagId: params[:tagId], candidacyIds: params[:candidacies].join(','))
    end
  end
  
  def compare
    @election   = Election.first conditions: {namespace: params[:election_namespace]}
    # returns 404 if election does not exist
    return not_found unless @election
    
    # candidacies
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
    
    propositions = Proposition.where :candidacy_id.in => params[:candidacyIds].split(','),
                                     :tag_ids => params[:tagId]
                                     
    @tags_propositions = {}
    propositions.each do |proposition|
      proposition.tags.each do |tag|
        @tags_propositions[tag.id.to_s] = [] unless @tags_propositions[tag.id.to_s]
        @tags_propositions[tag.id.to_s] << proposition
      end
    end
  end
  
end