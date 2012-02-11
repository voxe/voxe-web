class Api::V1::ComparisonsController < ApplicationController
  
  def search
    # returns the last 20 comparisons
    @events = Event.where(name: "comparison").desc(:created_at).limit(20)
  end
  
end