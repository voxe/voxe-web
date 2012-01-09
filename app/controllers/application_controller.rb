class ApplicationController < ActionController::Base
  
  protect_from_forgery
  
  rescue_from CanCan::AccessDenied do |exception|
    authenticate_user!
  end
  
  before_filter :set_format
  
  helper_method :touch_device
  
  private
    
    # http://stackoverflow.com/questions/2385799/how-to-redirect-to-a-404-in-rails
    def not_found
      raise ActionController::RoutingError.new('Not Found')
    end
    
    def set_format
      set_touch_format
      set_mobile_format
    end
  
    def set_touch_format
      if touch_device?
        request.format = :touch
      end
    end
    
    def set_mobile_format
      if mobile_device?
        request.format = :mobile
      end
    end
  
    def touch_device?
      request.user_agent.to_s.downcase =~ /iphone|android|ipad/
    end
    
    def mobile_device?
      request.user_agent.to_s.downcase =~ /blackberry/
    end
    
    # returns 'android', 'iphone' or nil
    def touch_device
      return 'iphone' if request.user_agent.to_s.downcase =~ /iphone/
      return 'android' if request.user_agent.to_s.downcase =~ /android/
      nil
    end
  
end