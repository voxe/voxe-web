task "setup" => :environment do
  
  # drop existing DB
  Rake::Task["db:mongoid:drop"].execute
  
  # create admin@admin.com user
  user = User.new
  user.email = 'admin@voxe.org'
  user.password = 'password'
  user.admin = true
  user.save!
  
  # launch france 2007 migration
  Rake::Task["migrate:france2007"].execute
  
end