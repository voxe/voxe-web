class UxController < ApplicationController
  
  def index
    version = params[:v].blank? ? "index" : "v#{params[:v]}"
    render :layout => false, :template => "ux/#{version}"
  end
  
end
