class Proposition
  include Mongoid::Document
  include Mongoid::Timestamps

  field :text, type: String
  field :support_users_count, type: Integer, default: 0
  field :against_users_count, type: Integer, default: 0
  field :favorite_users_count, type: Integer, default: 0

  belongs_to :candidacy
  has_and_belongs_to_many :tags, inverse_of: nil
  
  # indexes
  index({ candidacy_id: 1, tag_ids: 1 }, { background: true })
  index({ candidacy_id: 1, support_users_count: 1 }, { background: true })
  index({ candidacy_id: 1, against_users_count: 1 }, { background: true })
  index({ candidacy_id: 1, favorite_users_count: 1 }, { background: true })

  validates_presence_of :candidacy, :tags, :text

  embeds_many :embeds, as: :embedable
  embeds_many :comments
  accepts_nested_attributes_for :embeds, :allow_destroy => true, :reject_if => proc { |obj| obj.blank? }
  has_many :user_actions

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
    unless tag = Tag.where({name: name}).first
      tag = Tag.create name: name
    end
    self.tags << tag
  end

  def support_users
    self.user_actions.where(action: 'support')
  end

  def against_users
    self.user_actions.where(action: 'against')
  end

  def favorite_users
    self.user_actions.where(action: 'favorite')
  end

  private

  def add_parent_tags
    return false unless candidacy and candidacy.election
    all_tags = self.tags.to_a
    for tag in all_tags do
      election_tag = candidacy.election.election_tags.where(tag_id: tag.id).first
      parent_tag = election_tag.try(:parent_tag)
      if parent_tag and not tags.include?(parent_tag)
        all_tags << parent_tag
      end
    end
    self.tags = all_tags
  end
end
