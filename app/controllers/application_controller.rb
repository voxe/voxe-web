class ApplicationController < ActionController::Base
  
  protect_from_forgery
  
  rescue_from CanCan::AccessDenied do |exception|
    authenticate_user!
  end
  
  before_filter :set_touch_format
  
  private
  
    def set_touch_format
      if touch_device?
        request.format = :touch
      end
    end
  
    def touch_device?
      request.user_agent.to_s.downcase =~ /iphone|android/
    end
  
end