class Web::StaticController < ApplicationController
  
  # # will be reset every deploy
  caches_action :team, :about, :press, :terms, :join, :apps, :thanks, :live
  
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

  def thanks
  end
  
  def live
  end
  
end
