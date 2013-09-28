if Rails.env.production? or Rails.env.staging?
  ActionMailer::Base.smtp_settings = {
    :address        => 'smtp.sendgrid.net',
    :port           => '587',
    :authentication => :plain,
    :user_name      => ENV['SENDGRID_USERNAME'],
    :password       => ENV['SENDGRID_PASSWORD'],
    :domain         => 'voxe.org'
  }
  ActionMailer::Base.delivery_method = :smtp
elsif Rails.env.development?
  class DevelopmentMailInterceptor
    def self.delivering_email(message)
      message.subject = "Interceptor #{message.to} | #{message.subject}"
      message.to = `git config --global user.email`.gsub("\n", '')
    end
  end

  ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor)
  ActionMailer::Base.delivery_method :test
else
  ActionMailer::Base.delivery_method :test
end
