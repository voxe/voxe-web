namespace :cron do
  task :notify_propositions_updated => :environment do
    require File.join(Rails.root, 'app/mailers/user_mailer.rb')
    UserMailer.admin_proposition_updated.deliver
    puts "Email sent"
  end
end
