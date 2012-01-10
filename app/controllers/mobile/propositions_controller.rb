class Mobile::PropositionsController < ApplicationController
  
  def show
    @proposition = Proposition.find params[:id]
  end
  
end