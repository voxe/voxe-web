module Mobile::ApplicationHelper
  
  def title
    return "Voxe" if @title.blank?
    "#{@title} | Voxe"
  end
  
end
