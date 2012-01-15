class Webviews::PropositionsController < Webviews::ApplicationController
  
  def show
    begin
      @proposition = Proposition.find params[:id]
    rescue Mongoid::Errors::DocumentNotFound
      return render text: "invalid propositionId"
    end
  end
  
end