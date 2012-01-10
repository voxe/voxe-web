class Mobile::TagsController < Mobile::ApplicationController
  
  before_filter :set_election
  
  def index
    if params[:candidacies].blank?
      redirect_to @election
    end
    # 
    # unless params[:tagId].blank?
    #   redirect_to election_compare_path(@election, tagId: params[:tagId], candidacyIds: params[:candidacies].join(','))
    # end
  end
  
end
