namespace :analysis do
  task :tags_without_propositions => :environment do

    Election.all.each do |election|
      puts "=> #{election.name}"
      election.election_tags.each do |election_tag|
        propositions = Proposition.where(:tag_ids.in => [election_tag.tag.id], :candidacy_id.in => election.candidacies.collect(&:id))
        puts "#{propositions.count}\t#{election_tag.tag.name}" if propositions.count.zero?
      end
    end

  end
end