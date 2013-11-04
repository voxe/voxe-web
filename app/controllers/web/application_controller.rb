class Web::ApplicationController < ApplicationController
  before_filter :set_locale

  # will be reset every deploy
  caches_action :index

  def index
    @options = {}
  end

  AVAILABLE_LANGUAGES = I18n.available_locales.map do |l| l.to_s end
  def set_locale
    if request.user_preferred_languages.present?
      I18n.locale = request.preferred_language_from(AVAILABLE_LANGUAGES)
    else
      I18n.locale = I18n.default_locale
    end
  end

  private
    def set_election
      @only_published_candidacies = true
      @election = Election.where({namespace: params[:namespace]}).first
      # returns 404 if election does not exist
      return not_found unless @election
    end

end
