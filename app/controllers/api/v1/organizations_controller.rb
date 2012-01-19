class Api::V1::OrganizationsController < Api::V1::ApplicationController
  # POST /api/v1/organizations
  def create
    if @organization.save
      render 'api/v1/organizations/show.rabl'
    else
      render text: {errors: @organization.errors}.to_json, status: :unprocessable_entity, layout: 'api_v1'
    end
  end
end
