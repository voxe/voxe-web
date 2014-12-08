namespace :cron do
  task :notify_propositions_updated => :environment do
    require File.join(Rails.root, 'app/mailers/user_mailer.rb')
    propositions = Proposition.where(:updated_at.gte => Date.yesterday.beginning_of_day, :updated_at.lte => Date.yesterday.end_of_day)
    if propositions.present?
      UserMailer.admin_proposition_updated(propositions).deliver
      puts "Email sent"
    end
  end
end
