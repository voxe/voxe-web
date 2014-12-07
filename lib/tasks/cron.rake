task :notify_propositions_updated => :environment do
  UserMailer.admin_proposition_updated.deliver
end
