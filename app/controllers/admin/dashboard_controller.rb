class Admin::DashboardController < ApplicationController
  layout 'admin'
  authorize_resource class: false

  def index
  end
end
