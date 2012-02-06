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
  
  # apps
  def link_to_app_store text
    link_to text, "http://itunes.apple.com/fr/app/voxe.org-election-presidentielle/id497900258?mt=8", target: "_blank"
  end
  
  def link_to_android_market text
    link_to text, "https://market.android.com/details?id=org.voxe.android", target: "_blank"
  end
  
end