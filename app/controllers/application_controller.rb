class ApplicationController < ActionController::Base
  
  protect_from_forgery
  
  rescue_from CanCan::AccessDenied do |exception|
    authenticate_user!
  end

  layout :layout_by_resource

  protected

  def layout_by_resource
    if devise_controller?
      "devise"
    else
      "application"
    end
  end
  
  private
    
    # http://stackoverflow.com/questions/2385799/how-to-redirect-to-a-404-in-rails
    def not_found
      raise ActionController::RoutingError.new('Not Found')
    end
  
end