class AdminController < ActionController::Base
  before_filter :authenticate_user!
  # Paranoia, because CanCan already care about this
  before_filter do
    unless current_user.admin? or current_user.ambassador_elections.present? or current_user.contributor_elections.present?
      render :status => :forbidden, :text => "Forbidden"
    end
  end
  before_filter :set_locale
  layout 'new_admin'

  respond_to :html

  protect_from_forgery

  private

  def current_ability
    @current_ability ||= AdminAbility.new(current_user)
  end

  def set_locale
    session[:locale] = params[:locale] if params[:locale].present?
    I18n.locale = session[:locale] if session[:locale].present?
  end

end
