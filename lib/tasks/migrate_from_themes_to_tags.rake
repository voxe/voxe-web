namespace :migrate do
  task :from_themes_to_tags => :environment do
    Proposition.all.each do |proposition|
      proposition.tag_names = [proposition.theme.name, proposition.theme.theme.name, proposition.theme.theme.theme.name]
      proposition.save
    end
  end
end
