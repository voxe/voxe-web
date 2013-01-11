class Election
  include Mongoid::Document
  
  # attributes
  field :name, type: String
  field :namespace, type: String
  field :published, type: Boolean, default: false
  field :date, type: Date
  attr_reader :country_namespace
  
  # relations
  belongs_to :parent_election, class_name: 'Election'
  has_many :elections, foreign_key: 'parent_election_id'
  has_many :candidacies, autosave: true
  has_and_belongs_to_many :ambassadors, class_name: 'User', inverse_of: :ambassador_elections
  has_and_belongs_to_many :contributors, class_name: 'User', inverse_of: :contributor_elections
  belongs_to :country
  
  # validations
  validates_presence_of :name, :namespace
  validates_uniqueness_of :namespace

  # Scopes
  scope :published, where(published: true)

  def root_election_tags
    ElectionTag.where({election_id: parent_election ? parent_election.id : self.id, parent_tag_id: nil}).includes(:tag)
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
    # pierre: ugly hack to put the french candidates for the second "tour" at the top
    if id.to_s == '4f16fe2299c7a10001000012'
      array.insert(0, array.delete_at(4)) # hollande
      array.insert(1, array.delete_at(9)) # sarkozy
    end
    array
  end

  def country_namespace= namespace
    @country_namespace = namespace
    self.country = Country.where(namespace: @country_namespace).first
    @country_namespace
  end

end
