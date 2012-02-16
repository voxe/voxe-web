namespace :cache do
  task :clear => :environment do
    puts "== Clearing Memcache"
    Rails.cache.clear
  end
end