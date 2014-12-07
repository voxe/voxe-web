class UserMailer < ActionMailer::Base
  default from: "content@voxe.org", bcc: "content@voxe.org"

  def backoffice_thank_you user
    @user = user
    mail(to: @user.email, subject: "Candidats - Votre inscription sur Voxe.org")
  end

  def backoffice_confirmed user
    @user = user
    mail(to: @user.email, subject: "Voxe.org - Votre inscription est validée")
  end

  def admin_ambassador_granted user, election
    @user = user
    mail(to: @user.email, subject: "Profile approved")
  end

  def admin_proposition_updated
    @propositions = Proposition.where(:updated_at.gte => Date.yesterday.beginning_of_day, :updated_at.lte => Date.yesterday.end_of_day)
    mail(to: 'content@voxe.org', subject: 'Propositions updated')
  end
end
