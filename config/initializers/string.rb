class String
    
  def to_url
    return self if self[0..3] == 'http'
    "http://#{Settings.host}#{self}"
  end
  
end