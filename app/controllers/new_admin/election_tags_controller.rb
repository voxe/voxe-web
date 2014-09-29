class NewAdmin::ElectionTagsController < AdminController
  load_and_authorize_resource :election, find_by: :namespace
  before_filter :load_election_tags
  authorize_resource

  def index
    @tag ||= Tag.new
  end

  private

  def load_election_tags
    @election_tags = @election.election_tags.
      select{|et| et.root? }.
      sort{|et1,et2| et1.tag.name <=> et2.tag.name}
  end
end
