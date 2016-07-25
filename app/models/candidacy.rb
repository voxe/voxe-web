class Candidacy
  include Mongoid::Document

  #
  # Attributes
  #
  field :published, type: Boolean, default: false

  #
  # Associations
  #
  belongs_to :user
  has_one :candidate_profile, class_name: 'CandidacyCandidateProfile'
  belongs_to :election
  belongs_to :organization
  has_many   :propositions
  has_and_belongs_to_many :candidates
  belongs_to :owner, class_name: 'User'

  #
  # Validations
  #
  validates_presence_of :election
  validate :at_least_one_candidate

  #
  # Scopes
  #
  scope :published, where(published: true)

  # TODO: remove temp hack
  def name
    candidates[0].try(:name)
  end

  def election_name_with_candidacy
    if self.election.present?
      self.election.name + ' - ' + self.name
    else
      nil
    end
  end

  # TODO: remove temp hack
  def namespace
    candidates[0].try(:namespace)
  end

  def candidate_id= candidate_id
    @candidate_id ||= candidate_id
    candidate = Candidate.find(candidate_id)
    self.candidates << candidate
  end

  def candidate_id
    @candidate_id
  end

  private

  def at_least_one_candidate
    if self.candidates.empty?
      self.errors.add :candidates, "Need at least one"
    end
  end

end
