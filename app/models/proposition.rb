class Proposition
  include Mongoid::Document
  include Mongoid::Timestamps

  field :text, type: String

  belongs_to :candidacy
  has_and_belongs_to_many :tags
  
  # indexes
  index [[:candidacy_id, Mongo::ASCENDING], [:tag_ids, Mongo::ASCENDING]]

  validates_presence_of :candidacy, :tags, :text

  embeds_many :embeds, as: :embedable
  embeds_many :comments
  accepts_nested_attributes_for :embeds, :allow_destroy => true, :reject_if => proc { |obj| obj.blank? }

  before_save :add_parent_tags

  attr_reader :tag
  
  def tag= name
    self.add_tag name
  end

  def tag_names
    tags.collect(&:name)
  end

  def tag_names= names
    self.tag_ids = [] # reset tags (self.tags = [] not working for this)
    names.each do |name|
      self.add_tag name
    end
    self.tags
  end

  def add_tag name
    unless tag = Tag.first(conditions: {name: name})
      tag = Tag.create name: name
    end
    self.tags << tag
  end

  private

  def add_parent_tags
    return false unless candidacy and candidacy.election
    for tag in self.tags do
      election_tag = candidacy.election.election_tags.where(tag_id: tag.id).first
      parent_tag = election_tag.try(:parent_tag)
      if parent_tag and not tags.include?(parent_tag)
        self.tags << parent_tag
      end
    end
    self.tags
  end
end
