class Web::StaticController < Web::ApplicationController

  # # will be reset every deploy
  caches_action :team, :apps, :press

  def team
  end

  def about
    if I18n.locale == :fr
      @post_id = 18435358007
    else
      @post_id = 95739922215
    end
    render action: "tumblr"
  end

  def how
    if I18n.locale == :fr
      @post_id = 18435068606
    else
      @post_id = 95739994350
    end
    render action: "tumblr"
  end

  def press
    @post_id = 18436410010
    render action: "tumblr"
  end

  def apps
  end

  def thanks
    if I18n.locale == :fr
      @post_id = 18436182546
    else
      @post_id = 95740225780
    end
    render action: "tumblr"
  end

end
