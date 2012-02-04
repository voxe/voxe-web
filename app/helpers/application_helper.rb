module ApplicationHelper
  
  def page_title
    return "Voxe.org" if @page_title.blank?
    "#{@page_title} | Voxe.org"
  end
  
  def page_description
    @page_description || 'Comparer les programmes des candidats'
  end
  
  def page_image
    @page_image || asset_path('icons/128.png')
  end
  
end