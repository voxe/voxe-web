class Election
  include MongoMapper::Document

  key :name, String
  key :candidate_ids, Array
  key :theme_ids, Hash

  many :candidates, :in => :candidate_ids
  # FIXME many :themes
  
end
