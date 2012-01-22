class Web::StaticController < ApplicationController
  
  def team
    @people = File.open(Rails.root.join('config','team.yml')) { |file| YAML::load(file) }
  end
  
  def about
  end
  
  def press
  end
  
  def terms
  end
  
  def join
  end
  
  def apps
  end
  
end