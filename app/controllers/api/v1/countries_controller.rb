class Api::V1::CountriesController < Api::V1::ApplicationController

  # GET /api/v1/countries/search
  def search
    @countries = Country.where(name: /#{params[:name]}/i)
  end

  # POST /api/v1/countries
  def create
    if @country.save
      render 'api/v1/countries/show.rabl', status: :created
    else
      render text: {errors: @country.errors}.to_json, status: :unprocessable_entity, layout: 'api_v1'
    end
  end

end
