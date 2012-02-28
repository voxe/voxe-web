class Web::StaticController < ApplicationController
  
  # # will be reset every deploy
  caches_action :team, :about, :press, :terms, :join, :apps, :thanks, :live, :how
  
  def team
    @people = File.open(Rails.root.join('config','team.yml')) { |file| YAML::load(file) }
  end
  
  def about
    @post_id = 18435358007
    render action: "tumblr"
  end
  
  def how
    @post_id = 18435068606
    render action: "tumblr"
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
