namespace :models do
  task "generate_slug" => :environment do
    Country.all.map do |c| 
      c._slugs = [ c.name.parameterize ]
      c.save!
    end
    Election.all.map do |e| 
      e._slugs = [ e.name.parameterize ]
      e.save!
    end
  end
end
