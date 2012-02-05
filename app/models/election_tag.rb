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
  index [[:parent_tag_id, Mongo::ASCENDING], [:election_id, Mongo::ASCENDING]]
  
  # validations
  validates_uniqueness_of :tag_id, :scope => :election_id
  validates_presence_of :election, :tag

  # Callbacks
  after_destroy :destroy_children

  default_scope order_by [[:position, :asc]]

  def children_election_tags
    ElectionTag.all conditions: {parent_tag_id: tag.id, election_id: election.id}
  end
  
  # def ancestors_tags
  #   ancestors = []
  #   current_election_tag = self
  #   while current_election_tag.parent_tag.present?
  #     ancestors << current_election_tag.parent_tag
  #     current_election_tag = self.class.where(tag_id: current_election_tag.parent_tag.id)
  #   end
  #   ancestors
  # end

  def position
    rand 1000
  end
  
  def root?
    parent_tag == nil
  end

  private

  def destroy_children
    children_election_tags.destroy_all
  end
end