namespace :migrate do
  task "france2007" => :environment do
    # create election
    election = Election.create! name: "Election Presidentielle France 2007",
                                namespace: "france-presidentielle-2007",
                                published: true

    # themes
    all_themes = YAML.load_file "data/france2007/themes.yml"
    themes = {}
    all_themes.each { |theme| themes[theme["id_rubrique"]] = theme }    
    puts "#themes: #{themes.count}"
    
    # sections
    all_sections = YAML.load_file "data/france2007/sections.yml"
    sections = {}
    all_sections.each do |section|
      sections[section["id_parent"]] = [] if sections[section["id_parent"]].blank?
      sections[section["id_parent"]] << section
    end
    puts "#sections: #{sections.count}"
    
    # categories
    all_categories = YAML.load_file "data/france2007/categories.yml"
    categories = {}
    all_categories.each do |category|
      categories[category["id_parent"]] = [] if categories[category["id_parent"]].blank?
      categories[category["id_parent"]] << category
    end
    puts "#categories: #{categories.count}"
    
    # create tags and hierarchy of tags    
    themes.each do |theme_id, theme|
      # create tag
      tag1 = Tag.create!(:name => theme["titre"])
      # add tag to root level of election
      ElectionTag.create! election: election, tag: tag1
      
      sections[theme_id].each do |section|
        # create tag
        tag2 = Tag.create!(:name => section["titre"])
        ElectionTag.create! election: election, tag: tag2, parent_tag: tag1
                
        categories[section["id_rubrique"]].each do |category|
          # create tag
          tag3 = Tag.create!(:name => category["titre"])
          ElectionTag.create! election: election, tag: tag3, parent_tag: tag2
        end
      end
    end
    
    # prepare candidates
    c = YAML.load_file "data/france2007/candidates.yml"
    candidates = {}
    c.each do |candidate|
      candidates[candidate["id_mot"]] = candidate
    end
    puts "#candidates: #{candidates.count}"
    
    # create candidates
    candidacies_ids = {}
    candidates.each do |candidate_id, candidate|
      c = Candidate.new(:first_name => candidate["descriptif"], :last_name => candidate["titre"])
      c.namespace = "#{c.first_name}-#{c.last_name}".parameterize
      c.save!
      candidacy = election.candidacies.build
      candidacy.candidates << c
      candidacy.published = true
      candidacy.save!
      candidacies_ids[candidate_id] = candidacy.id
    end
    
    # propositions
    all_propositions = YAML.load_file "data/france2007/propositions.yml"
    all_propositions.each do |proposition|
      category = all_categories.select { |category| category["id_rubrique"] == proposition["id_rubrique"] }.first
      section = all_sections.select { |section| section["id_rubrique"] == category["id_parent"] }.first
      theme = all_themes.select { |theme| theme["id_rubrique"] == section["id_parent"] }.first

      unless proposition["descriptif"].blank?
        proposition["descriptif"].split("\r\n").each do |text|
          model = Proposition.new
          model.election = election
          model.candidacy_id = candidacies_ids[proposition["id_mot"]]
          # tags
          tag_category = Tag.first conditions: {name: category['titre']}
          tag_section = Tag.first conditions: {name: section['titre']}
          tag_theme = Tag.first conditions: {name: theme['titre']}
          model.tags = [tag_category, tag_section, tag_theme]
          # text
          model.text = text
          model.save!
        end
      end
    end
    puts "propositions: #{all_propositions.count}"
  end
  
end