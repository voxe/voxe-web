class Election
  include Mongoid::Document
  
  # attributes
  field :name, type: String
  field :namespace, type: String
  field :published, type: Boolean, default: false
  
  # relations
  belongs_to :parent_election, class_name: 'Election'
  has_many :elections, foreign_key: 'parent_election_id'
  has_many :candidacies, autosave: true
  has_and_belongs_to_many :contributors, class_name: 'User'
  
  # validations
  validates_presence_of :name, :namespace
  validates_uniqueness_of :namespace

  # Scopes
  scope :published, where(published: true)

  def root_election_tags
    ElectionTag.all(conditions: {election_id: parent_election ? parent_election.id : self.id, parent_tag_id: nil}).includes(:tag)
  end

  def election_tags
    ElectionTag.where(election_id:(parent_election ? parent_election.id : self.id)).includes(:tag)
  end

  def to_param
    self.namespace
  end
  
  def candidacies_sorted
    array = candidacies
    array.sort_by! { |candidacy| candidacy.candidates[0].last_name }
  end

  def published_candidacies_sorted
    array = candidacies.published.entries
    array.sort_by! { |candidacy| candidacy.candidates[0].last_name }
  end

end