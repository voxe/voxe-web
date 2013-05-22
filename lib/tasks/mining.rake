namespace :mining do

  task :process_ip_addresses => :environment do
    require 'geocoder'
    events = Event.where(:processed => false, :ip_address.nin => ['"127.0.0.1"', '127.0.0.1', nil])
    total = events.size
    puts "Processing #{total}..."
    events.each_with_index do |event, i|
      puts "#{i*100.0/total}%..."
      event.clear_ip!
      next unless event.ip_address.present?
      g = Geocoder.search(event.ip_address)
      if g and result = g.first
        event.update_attributes({
          processed: true,
          location: {lat: result.latitude, lng: result.longitude},
          country_code: result.country_code,
          city: result.city
        })
      else
        puts 'no result'
      end
    end
  end

  task :export_logs => :environment do
    require 'csv'

    puts "Exporting events..."
    folder = File.join(Rails.root, 'tmp/mining')
    Dir.mkdir(folder) unless File.exists?(folder)
    events_csv = CSV.open(File.join(folder, "events.csv"), "w")

    events_csv << [
      'name',
      'ip_address',
      'user_driven',
      'tag_name',
      'candidacies_counter',
      'candidate_a',
      'candidate_b'
    ]

    counter = Event.count
    Event.desc(:created_at).limit(1_000).each_with_index do |event, i|
      puts "#{i*100.0/counter}..."
      events_csv << [
        event.name,
        event.ip_address,
        event.user_driven,
        event.tags.first.try(:name),
        event.candidacies.count,
        event.candidacies.first.try(:name),
        event.candidacies.last.try(:name),
      ]
    end

    puts "Export finished"
    events_csv.close

  end

end
