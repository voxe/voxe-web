namespace :setup do
  task "admin" => :environment do
  
    # create admin@voxe.org user
    user = User.new
    user.email = 'admin@voxe.org'
    user.name = 'Voxe Admin'
    user.password = 'password'
    user.admin = true
    user.save!
  
  end
end