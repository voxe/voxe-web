class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :text, type: String
  
  belongs_to :user
  embedded_in :proposition

  validates_presence_of :user, :text
end
