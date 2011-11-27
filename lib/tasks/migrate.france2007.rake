namespace :migrate do
  task "france2007" => :environment do
    
    t = YAML.load_file "data/france2007/themes.yml"
    themes = {}
    t.each { |theme| themes[theme["id_rubrique"]] = theme }    
    # puts themes.inspect
    puts "themes: #{themes.count}"
    
    s = YAML.load_file "data/france2007/sections.yml"
    sections = {}
    s.each do |section|
      sections[section["id_parent"]] = [] if sections[section["id_parent"]].blank?
      sections[section["id_parent"]] << section
    end
    # sections.each do |key, items|
    #   items.sort! { |item| item["titre"] }
    # end
    # puts sections.inspect
    
    c = YAML.load_file "data/france2007/categories.yml"
    categories = {}
    c.each do |category|
      categories[category["id_parent"]] = [] if categories[category["id_parent"]].blank?
      categories[category["id_parent"]] << category
    end
    puts "categories: #{categories.count}"
    
    election = Election.create(:name => "Election France 2007")
    
    categories_ids = {}
    
    themes.each do |theme_id, theme|
      # puts "- theme: #{theme_id} - #{theme["titre"]}"
      # create theme and match id
      t = Theme.create(:name => theme["titre"])
      election.themes << t
      
      sections_ids = []
      
      sections[theme_id].each do |section|
        # add section to theme
        s = Theme.new(:name => section["titre"])
        s.theme = t
        s.save!
        # match ids
        sections_ids[section["id_rubrique"]] = s.id
        
        puts "-- section: #{section["id_rubrique"]} #{section["titre"]}"
        
        categories[section["id_rubrique"]].each do |category|
          # add category to section
          c = Theme.new(:name => category["titre"])
          c.theme = s
          c.save!
          
          categories_ids[category["id_rubrique"]] = c.id
          
          puts "--- category: #{category["id_rubrique"]} #{category["titre"]}"
        end
      end
    end
    
    c = YAML.load_file "data/france2007/candidates.yml"
    candidates = {}
    c.each do |candidate|
      candidates[candidate["id_mot"]] = candidate
    end
    puts "candidates: #{candidates.count}"
    
    candidates_ids = {}
    candidates.each do |candidate_id, candidate|
      puts "#{candidate.inspect}"
      c = Candidate.create!(:firstName => candidate["descriptif"], :lastName => candidate["titre"])
      c.elections << election
      candidates_ids[candidate_id] = c.id
    end
        
    p = YAML.load_file "data/france2007/propositions.yml"
    propositions = []
    p.each do |proposition|
      candidate = candidates[proposition["id_mot"]]
      category = categories[proposition["id_rubrique"]]
      propositions << {candidate: candidate,category: category,text: proposition["descriptif"]}
      # puts "#{candidate["titre"]} #{candidate["descriptif"]} #{category["titre"]} #{proposition["descriptif"]}"
      
      unless proposition["descriptif"].blank?
        puts "#{proposition["descriptif"].split("\r\n").inspect}"
        proposition["descriptif"].split("\r\n").each do |text|
          model = Proposition.new
          model.candidateId = candidates_ids[proposition["id_mot"]]
          model.themeId = categories_ids[proposition["id_rubrique"]]
          model.election = election
          model.text = text
          model.save!
        end
      end
    end
    puts "propositions: #{propositions.count}"
  end
  
end