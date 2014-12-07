class Proposition
  include Mongoid::Document
  include Mongoid::Timestamps

  USER_ACTIONS = %w(favorite against support)

  field :text, type: String

  belongs_to :candidacy
  belongs_to :updated_by, class_name: 'User'
  has_and_belongs_to_many :tags, inverse_of: nil

  # indexes
  index({ candidacy_id: 1, tag_ids: 1 }, { background: true })

  def self.field_name_for_counter_cache(action)
    "UserAction::#{action.camelcase}".constantize.proposition_cache_field
  end
  USER_ACTIONS.each do |action|
    field_name = field_name_for_counter_cache(action)
    field field_name, type: Integer, default: 0
    index({ candidacy_id: 1, field_name => 1 }, { background: true })
  end

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
    unless tag = Tag.where({name: name}).first
      tag = Tag.create name: name
    end
    self.tags << tag
  end

  # Options
  # anonymous: true to get anonymous users
  USER_ACTIONS.each do |action|
    define_method "#{action}_users" do |options={}|
      options[:anonymous] ||= false
      klass = "UserAction::#{action.camelcase}".constantize
      klass.where(proposition: self).reduce([]) do |users, user_action|
        users << user_action.user if options[:anonymous] || (not user_action.user.is_anonymous?)
        users
      end
    end
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
