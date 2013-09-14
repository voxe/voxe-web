class Backoffice::BackofficeController < ApplicationController
  layout 'backoffice'
  respond_to :html, :json
  before_filter :authenticate_user!

  protected

  def current_ability
    @_current_ability ||= BackofficeAbility.new(current_user)
  end

end
