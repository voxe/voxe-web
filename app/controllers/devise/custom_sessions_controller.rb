class Devise::CustomSessionsController < Devise::SessionsController
  skip_before_filter :require_no_authentication, only: :new
  before_filter :sign_out_user, only: :new

  private

  def sign_out_user
    sign_out(:user) if user_signed_in?
  end
end
