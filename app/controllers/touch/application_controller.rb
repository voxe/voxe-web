class Touch::ApplicationController < ApplicationController
  
  helper_method :touch_device
  
  private
  
    def set_election
      @election = Election.first conditions: {namespace: params[:namespace]}
      # returns 404 if election does not exist
      return not_found unless @election
    end
  
    # returns 'android', 'iphone' or nil
    def touch_device
      return 'iphone' if request.user_agent.to_s.downcase =~ /iphone/
      return 'android' if request.user_agent.to_s.downcase =~ /android/
      nil
    end
  
end