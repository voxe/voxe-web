class Mobile::PropositionsController < ApplicationController
  
  def show
    @proposition = Proposition.find params[:id]
    # open graph
    @page_title = "#{@proposition.candidacy.candidates.first.name} - #{@proposition.tags.second.name} (#{@proposition.tags.first.name})"
    @page_description = "#{@proposition.text.capitalize}"
    @page_image = @proposition.candidacy.candidates.first.photo_url(:large)
  end
  
end