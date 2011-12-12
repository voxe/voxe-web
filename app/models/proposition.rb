class Proposition
  include Mongoid::Document
  include Mongoid::Timestamps

  field :text,        type: String
  field :candidateId, type: String
  field :themeId,     type: String
  field :electionId,  type: String

  belongs_to :candidate, foreign_key: :candidateId
  belongs_to :theme,     foreign_key: :themeId
  belongs_to :election,  foreign_key: :electionId

  validates_presence_of :candidate, :theme, :election, :text

  embeds_many :embeds, as: :embedable
  accepts_nested_attributes_for :embeds, :allow_destroy => true, :reject_if => proc { |obj| obj.blank? }

end