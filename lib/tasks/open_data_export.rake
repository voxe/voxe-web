task :open_data_export => :environment do
  require 'csv'

  folder_name = File.join(Rails.root, 'tmp', "open_data_#{Process.pid}")

  puts "CSV exporting for open data to #{folder_name}"

  Dir.mkdir folder_name

  tags_csv          = CSV.open(File.join(folder_name, "tags.csv"), "w")
  elections_csv     = CSV.open(File.join(folder_name, "elections.csv"), "w")
  election_tags_csv = CSV.open(File.join(folder_name, "election_tags.csv"), "w")
  candidacies_csv   = CSV.open(File.join(folder_name, "candidacies.csv"), "w")
  propositions_csv  = CSV.open(File.join(folder_name, "propositions.csv"), "w")

  tags_csv          << ['id', 'name']
  elections_csv     << ['id', 'name', 'date']
  election_tags_csv << ['election_id', 'position', 'tag_id', 'parent_tag_id']
  candidacies_csv   << ['id', 'election_id', 'organization_name', 'candidate_first_name', 'candidate_last_name']
  propositions_csv  << ['id', 'candidacy_id', 'tag_ids', 'text']

  Tag.all.each do |tag|
    puts "- #{tag.namespace}"
    tags_csv << [
      tag.id.to_s,
      tag.name
    ]
  end

  Election.where(published: true).each do |election|
    puts "- #{election.namespace}"
    elections_csv << [
      election.id.to_s,
      election.name,
      election.date.to_s
    ]

    election.election_tags.each do |election_tag|
      election_tags_csv << [
        election_tag.election_id.to_s,
        election_tag.position,
        election_tag.tag_id,
        election_tag.parent_tag_id,
      ]
    end

    election.candidacies.where(published: true).each do |candidacy|
      puts " - #{candidacy.namespace}"
      candidacies_csv << [
        candidacy.id.to_s,
        candidacy.election_id.to_s,
        candidacy.organization.try(:name),
        candidacy.candidates.first.first_name,
        candidacy.candidates.first.last_name
      ]

      puts "   - #{candidacy.propositions.count} propositions"
      candidacy.propositions.each do |proposition|
        propositions_csv << [
          proposition.id.to_s,
          proposition.candidacy_id.to_s,
          proposition.tag_ids.to_s,
          proposition.text
        ]
      end
    end
  end

  elections_csv.close
  candidacies_csv.close
  propositions_csv.close

end
