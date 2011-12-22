class Proposition
  include Mongoid::Document
  include Mongoid::Timestamps

  field :text, type: String

  belongs_to :candidacy
  belongs_to :election
  has_and_belongs_to_many :tags

  validates_presence_of :candidacy, :tags, :election, :text

  embeds_many :embeds, as: :embedable
  accepts_nested_attributes_for :embeds, :allow_destroy => true, :reject_if => proc { |obj| obj.blank? }
  
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
end
