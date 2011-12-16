class Proposition
  include Mongoid::Document
  include Mongoid::Timestamps

  field :text,        type: String
  field :candidateId, type: String
  # TODO Remove this
  field :themeId,     type: String
  field :electionId,  type: String
  attr_reader :add_tag

  belongs_to :candidate, foreign_key: :candidateId
  # TODO Remove this
  belongs_to :theme,     foreign_key: :themeId
  belongs_to :election,  foreign_key: :electionId
  has_and_belongs_to_many :tags

  validates_presence_of :candidate, :theme, :election, :text

  embeds_many :embeds, as: :embedable
  accepts_nested_attributes_for :embeds, :allow_destroy => true, :reject_if => proc { |obj| obj.blank? }

  def tag_names
    tags.collect(&:name)
  end

  def tag_names= names
    names.each do |name|
      self.add_tag = name
    end
    tag_names
  end

  def add_tag= name
    @add_tag = name
    unless tag = Tag.first(conditions: {name: name})
      tag = Tag.create name: theme.name
    end
    self.tags << tag
  end
end
