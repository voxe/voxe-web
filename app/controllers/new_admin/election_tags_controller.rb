class NewAdmin::ElectionTagsController < AdminController
  def index
    @election = Election.find params[:election_id]
    @election_tags = @election.election_tags.
      select{|et| et.root? }.
      sort{|et1,et2| et1.tag.name <=> et2.tag.name}
  end
end
