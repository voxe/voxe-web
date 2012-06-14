class TouchConstraint

  def matches? request
    touch_device?(request) || touch_subdomain?(request)
  end

  def touch_device? request
    request.user_agent.to_s.downcase =~ /iphone|android/
  end

  def touch_subdomain? request
    request.subdomain.present? && request.subdomain == "touch"
  end

end
