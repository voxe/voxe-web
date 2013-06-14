class Event
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Spacial::Document

  #
  # Attributes
  #
  field :name,          type: String
  field :ip_address,    type: String
  field :user_driven,   type: Boolean, default: false

  # These fields are added by a batch stuff
  field :processed,     type: Boolean, default: false
  field :location,      type: Array, spacial: true
  field :country_code,  type: String
  field :city,          type: String

  #
  # Associations
  #
  has_and_belongs_to_many :candidacies, inverse_of: nil
  has_and_belongs_to_many :tags, inverse_of: nil

  #
  # Validations
  #
  validates_inclusion_of :name, :in => %w( comparison )

  #
  # Indexes
  #
  index({ name: 1, created_at: -1 }, { background: true })
  index({ processed: 1 }, { background: true })
  index({ candidacy_ids: 1 }, { background: true })
  index({ tag_ids: 1 }, { background: true })

  def clear_ip!
    return false unless self.ip_address
    self.update_attribute :ip_address, self.ip_address.strip.gsub('"', '')
  end

  def to_heatmap
    {
      lat: self.location[:lat],
      lon: self.location[:lng],
      value: 1
    }
  end

end
