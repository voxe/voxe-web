namespace :setup do
  task "admin" => :environment do
  
    # create or update admin@voxe.org user
    user = User.where(email: "admin@voxe.org").first
    unless user
      user = User.new
      user.email = 'admin@voxe.org'
      user.name = 'Voxe Admin'
    end
    user.password = 'password'
    user.admin = true
    user.save!
  
  end
end