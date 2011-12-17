namespace :migrate do
  task :from_themes_to_tags => :environment do
    # migrate themes to tags
    Theme.all.each do |theme|
      tag = Tag.first(conditions: {name: theme.name})
      unless tag
        tag = Tag.create!(name: theme.name)
      end
    end
    
    # migrate themes to election's tags
    Theme.all.each do |theme|
      tag = Tag.first(conditions: {name: theme.name})
      if theme.theme
        parent_tag = Tag.first(conditions: {name: theme.theme.name})
      end
      
      election = theme.try(:theme).try(:theme).try(:election) || theme.try(:theme).try(:election) || theme.election
      
      ElectionTag.create!(election: election, tag: tag, parent_tag: parent_tag)
    end
    
    # migration propositions
    Proposition.all.each do |proposition|
      proposition.tag_names = [proposition.theme.name, proposition.theme.theme.name, proposition.theme.theme.theme.name]
      proposition.save
    end
  end
end
