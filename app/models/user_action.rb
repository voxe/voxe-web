class UserAction
  include Mongoid::Document
  include Mongoid::Timestamps

  field :action, type: String

  belongs_to :user
  belongs_to :proposition

  index({ user_id: 1, proposition_id: 1, action: 1 }, { unique: true, background: true })
  index({ user_id: 1, action: 1 }, { background: true })
  index({ proposition_id: 1, action: 1 }, { background: true })

  validates_inclusion_of :action, in: %w{ support against favorite }
  
end
