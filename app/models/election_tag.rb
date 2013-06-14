class ElectionTag
  include Mongoid::Document
  include ActsAsList::Mongoid

  # attributes
  field :position,      type: Integer
  field :parent_tag_id, type: String  # can be null
  
  # relations
  belongs_to :election
  belongs_to :tag
  belongs_to :parent_tag, class_name: 'Tag'
  
  # indexes
  index({ parent_tag_id: 1, election_id: 1 }, { background: true })
  
  # validations
  validates_uniqueness_of :tag_id, :scope => :election_id
  validates_presence_of :election, :tag

  # Callbacks
  after_destroy :destroy_children

  default_scope order_by [[:position, :asc]]

  def children_election_tags
    ElectionTag.where({parent_tag_id: tag.id, election_id: election.id})
  end

  def position
    rand 1000
  end

  def root?
    parent_tag == nil
  end

  def leaf?
    self.children_election_tags.blank?
  end

  def to_s
    tag.name
  end

  private

  def destroy_children
    children_election_tags.destroy_all
  end
end