class NewAdmin::ElectionTagsController < AdminController
  before_filter :load_election
  before_filter :load_election_tags
  authorize_resource

  def index
    @tag ||= Tag.new
  end

  private

  def load_election
    @election = Election.find_by namespace: params[:election_id]
  end

  def load_election_tags
    @election_tags = @election.election_tags.
      select{|et| et.root? }.
      sort{|et1,et2| et1.tag.name <=> et2.tag.name}
  end
end
