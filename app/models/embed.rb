class Embed
  include Mongoid::Document

  #
  # Attributes
  #
  field :title, type: String
  field :url, type: String
  field :provider_name, type: String
  field :type, type: String
  field :html, type: String

  #
  # Relationships
  #
  embedded_in :embedable, polymorphic: true

  #
  # Validations
  #
  validates_presence_of :url
  validate :checkout_embed, if: :url_changed?
  
  # SUNDAY HACK !! WILL BE CHANGED IN THE FUTURE
  def youtube_id
    rexp = /v=(.*)/
    rexp.match(url).captures.first
  end
  
  def video_player
    # http://apiblog.youtube.com/2009/02/youtube-apis-iphone-cool-mobile-apps.html
    "<object width='270' height='200'>
    <param name='movie' value='http://www.youtube.com/v/#{youtube_id}'></param>
    <param name='wmode' value='transparent'></param>
    <embed src='http://www.youtube.com/v/#{youtube_id}'
    type='application/x-shockwave-flash' wmode='transparent' width='270' height='200'></embed>
    </object>"
  end


  private

  def checkout_embed
    require 'oembed'
    begin
      oembed = OEmbed::ProviderDiscovery.get url

      self.title         = oembed.title
      self.provider_name = oembed.provider_name
      self.type          = oembed.type
      self.html          = oembed.html
    rescue
      self.type = 'link'
    end

    true
  end
end