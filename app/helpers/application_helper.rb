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

  def add_country_form_url
    'https://docs.google.com/spreadsheet/viewform?fromEmail=true&formkey=dFRwZWdTMTFZQTc5UHhBeHZKTkwxaFE6MQ'
  end

  def add_election_form_url
    'https://docs.google.com/a/voxe.org/spreadsheet/viewform?fromEmail=true&formkey=dHJLX29POG05d04tR1loaE1ZaVFrVXc6MQ'
  end

  def true_or_false_icon boolean
    if boolean
      content_tag 'i', nil, class: 'icon-ok'
    else
      content_tag 'i', nil, class: 'icon-remove'
    end
  end
end
