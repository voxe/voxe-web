class Election
  include MongoMapper::Document

  key :name, String
  key :candidate_ids, Array
  key :theme_ids, Hash

  many :candidates, :in => :candidate_ids
  # FIXME many :themes

  def sub_themes_of theme_id
    Theme.find theme_ids[theme_id]
  end

  def compare theme_id, candidate_ids
    theme = Theme.find(theme_id)
    sub_themes = sub_themes_of(theme_id)
    candidates = Candidate.find(candidate_ids)

    # theme_hash = theme.merge({
    #   themes: sub_themes.collect do |sub_theme|
    #     sub_theme.to_json.merge({
    #       candidates.collect do |candidate|
    #         { propositions: Proposition.where(election: self, theme: sub_theme, candidate: candidate).to_json }
    #       end
    #     })
    #   end
    # })
    # 
    # [
    #   { candidates: candidates },
    #   { theme: theme_hash }
    # ]
  end

end
