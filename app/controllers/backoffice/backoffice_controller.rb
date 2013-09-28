class Backoffice::BackofficeController < ApplicationController
  layout 'backoffice'
  respond_to :html, :json
  before_filter :authenticate_user!
  before_filter :set_locale

  protected

  def current_ability
    @_current_ability ||= BackofficeAbility.new(current_user)
  end

  def load_profile
    if user_signed_in?
      @profile ||= current_user.candidacy_candidate_profile
    end
  end

  def load_candidacy
    @candidacy = @profile.candidacy
  end

  def load_election
    @election = @candidacy.election
  end

  def set_locale
    I18n.locale = :fr if Rails.env.development?
  end

end
