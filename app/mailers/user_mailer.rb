class UserMailer < ActionMailer::Base
  default from: "content@voxe.org", bcc: "content@voxe.org"

  def backoffice_thank_you user
    @user = user
    mail(to: @user.email, subject: "Candidats - Votre inscription sur Voxe.org")
  end
end
