class Webviews::ApplicationController < ApplicationController
  
  layout "webviews"
  
  helper_method :touch_device
  
  # returns 'android', 'iphone' or nil
  def touch_device
    return 'iphone' if request.user_agent.to_s.downcase =~ /iphone/
    return 'ipad' if request.user_agent.to_s.downcase =~ /ipad/
    return 'android' if request.user_agent.to_s.downcase =~ /android/
    nil
  end
  
end