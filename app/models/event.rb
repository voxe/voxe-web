class Event
  include Mongoid::Document
  include Mongoid::Timestamps

  #
  # Attributes
  #
  field :name,          type: String
  field :ip_address,    type: String
  field :candidacy_ids, type: Array
  field :tag_ids,       type: Array

  #
  # Validations
  #
  validates_inclusion_of :name, :in => %w( comparison )
  
  #
  # Indexes
  #
  
  index [[:name, Mongo::ASCENDING], [:created_at, Mongo::ASCENDING]]
  index [[:name, Mongo::ASCENDING], [:created_at, Mongo::DESCENDING]]

  def candidacies
    Candidacy.find(candidacy_ids)
  end
  
  def tags
    Tag.find(tag_ids)
  end

end
