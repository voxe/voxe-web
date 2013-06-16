class AdminController < ActionController::Base
  before_filter :authenticate_user!
  before_filter do
    if !current_user.admin?
      render :status => :forbidden, :text => "Forbidden"
    end
  end
  layout 'new_admin'

  respond_to :html

  protect_from_forgery
end
