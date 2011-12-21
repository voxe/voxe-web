class Election
  include Mongoid::Document
  
  # attributes
  field :name, type: String
  field :namespace, type: String
  
  # relations
  belongs_to :parent_election, class_name: 'Election'
  has_many :elections, foreign_key: 'parent_election_id'
  
  has_and_belongs_to_many :candidates
  has_many :propositions
  
  # validations
  validates_presence_of :name, :namespace
  validates_uniqueness_of :namespace
  
  def root_election_tags
    ElectionTag.all(conditions: {election_id: parent_election ? parent_election.id : self.id, parent_tag_id: nil})
  end
  
  def to_param
    self.namespace
  end

end