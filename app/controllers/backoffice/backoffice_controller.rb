class Backoffice::BackofficeController < ApplicationController
  layout 'backoffice'
  respond_to :html, :json
  before_filter :authenticate_user!

  helper_method :current_candidacy, :current_candidate

  protected
  def current_candidate
    @_current_candidate ||= current_candidacy.candidates[0]
  end

  def current_ability
    @_current_ability ||= BackofficeAbility.new(current_user)
  end

  def current_candidacy
    @_current_candidacy ||= current_user.candidacy
  end

end
