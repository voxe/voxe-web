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
end
