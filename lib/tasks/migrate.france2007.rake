namespace :migrate do
  task "france2007" do
    
    t = YAML.load_file "data/france2007/themes.yml"
    themes = {}
    t.each { |theme| themes[theme["id_rubrique"]] = theme }    
    # puts themes.inspect
    puts "themes: #{themes.count}"
    
    s = YAML.load_file "data/france2007/sections.yml"
    sections = {}
    all_sections = {}
    s.each do |section|
      sections[section["id_parent"]] = [] if sections[section["id_parent"]].blank?
      sections[section["id_parent"]] << section
      all_sections[section["id_rubrique"]] = section
    end
    # sections.each do |key, items|
    #   items.sort! { |item| item["titre"] }
    # end
    # puts sections.inspect
    puts "sections: #{all_sections.count}"
    
    c = YAML.load_file "data/france2007/categories.yml"
    categories = {}
    all_categories = {}
    c.each do |category|
      categories[category["id_parent"]] = [] if categories[category["id_parent"]].blank?
      categories[category["id_parent"]] << category
      all_categories[category["id_rubrique"]] = category
    end
    puts "categories: #{all_categories.count}"
    
    # themes.each do |theme_id, theme|
    #   puts "- theme: #{theme_id} - #{theme["titre"]}"
    #   sections[theme_id].each do |section|
    #     puts "-- section: #{section["id_rubrique"]} #{section["titre"]}"
    #     categories[section["id_rubrique"]].each do |category|
    #       puts "--- category: #{category["id_rubrique"]} #{category["titre"]}"
    #     end
    #   end
    # end
    
    c = YAML.load_file "data/france2007/candidates.yml"
    candidates = {}
    c.each do |candidate|
      candidates[candidate["id_mot"]] = candidate
    end
    puts "candidates: #{candidates.count}"
    
    p = YAML.load_file "data/france2007/propositions.yml"
    propositions = []
    p.each do |proposition|
      candidate = candidates[proposition["id_mot"]]
      category = all_categories[proposition["id_rubrique"]]
      propositions << {candidate: candidate,category: category,proposition: proposition}
      # puts "#{candidate["titre"]} #{candidate["descriptif"]} #{category["titre"]} #{proposition["descriptif"]}"
    end
    puts "propositions: #{propositions.count}"
    
  end
  
end