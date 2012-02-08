class Platform::EmbedController < ApplicationController
  
  layout 'platform'
  
  def index
    @election = Election.where(namespace: "france-presidentielle-2012").first
  end
  
  def button
  end
  
  def bookmarklet
    @election = Election.first
  end
  
end