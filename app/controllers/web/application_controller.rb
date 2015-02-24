class Web::ApplicationController < ApplicationController
  before_filter :set_locale

  # will be reset every deploy
  # caches_action :index

  def welcome
    
  end

  def index
    @options = {}
  end

  AVAILABLE_LANGUAGES = I18n.available_locales.map do |l| l.to_s end
  def set_locale
    if params[:locale].present? and params[:locale].in?(AVAILABLE_LANGUAGES)
      session[:locale] = params[:locale]
    elsif request.user_preferred_languages.present?
      session[:locale] = request.preferred_language_from(AVAILABLE_LANGUAGES)
    end
    I18n.locale = session[:locale] if session[:locale].present?
  end

  private
    def set_election
      @only_published_candidacies = true
      @election = Election.where({namespace: params[:namespace]}).first
      # returns 404 if election does not exist
      return not_found unless @election
    end

end
