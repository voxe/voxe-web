class MobileConstraint
  def matches? request
    wap_device?(request) || search_bot?(request) || facebook_bot?(request) || ie_6?(request)
  end

  def wap_device? request
    request.user_agent.to_s.downcase =~ /blackberry|nokia|ericsson|webos/
  end

  def search_bot? request
    if request.user_agent.present?
      user_agent = request.user_agent.downcase
      [ 'msnbot', 'yahoo! slurp','googlebot'].detect { |bot| user_agent.include? bot }
    end
  end

  def facebook_bot? request
    request.user_agent.to_s.downcase =~ /facebookexternalhit/
  end

  def ie_6? request
    request.user_agent.to_s.downcase =~ /msie 6/
  end
end
