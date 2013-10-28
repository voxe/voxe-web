class Api::V1::CitiesController < Api::V1::ApplicationController
  skip_load_and_authorize_resource
  def search
    @cities = City.where(:name => /^#{params[:name]}/i).limit(20).asc(:name)
  end
end
