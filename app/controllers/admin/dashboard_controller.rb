class Admin::DashboardController < ApplicationController
  layout 'backoffice'
  authorize_resource class: false

  def index
  end
end
