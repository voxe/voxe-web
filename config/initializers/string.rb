class String
    
  def to_url
    "#{Settings.host}#{self}"
  end
  
end