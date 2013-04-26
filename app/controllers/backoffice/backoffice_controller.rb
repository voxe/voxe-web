class Backoffice::BackofficeController < ApplicationController
  layout 'backoffice'
  respond_to :html, :json

  helper_method :current_candidate

  protected
  def current_candidate
    @_current_candidate ||= Candidate.unscoped.order_by([[:namespace, :asc]]).last
  end
end
