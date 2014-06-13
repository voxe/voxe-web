class Web::StaticController < Web::ApplicationController

  # # will be reset every deploy
  caches_action :team, :about, :how, :press, :apps, :thanks

  def team
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
    @post_id = 18436410010
    render action: "tumblr"
  end

  def apps
  end

  def thanks
    @post_id = 18436182546
    render action: "tumblr"
  end

end
