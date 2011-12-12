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


  private

  def checkout_embed
    require 'oembed'
    begin
      oembed = OEmbed::ProviderDiscovery.get url
    rescue OEmbed::NotFound => e
      errors.add :url, "can't be found"
      return false
    end

    self.title         = oembed.title
    self.provider_name = oembed.provider_name
    self.type          = oembed.type
    self.html          = oembed.html

    true
  end
end