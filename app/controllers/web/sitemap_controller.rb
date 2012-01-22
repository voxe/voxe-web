class Web::SitemapController < ApplicationController
  
  def index
    @urls = []
    # root
    url = {}
    url[:loc] = root_url
    url[:priority] = 1.0
    @urls << url
    # published elections
    Election.where(published: true).each do |election|
      url = {}
      url[:loc] = election_url election
      url[:priority] = 0.9
      @urls << url
      # candidates
      election.candidacies.each do |candidacy|
        url = {}
        url[:loc] = tags_url election, candidacy.namespace
        url[:priority] = 0.8
        @urls << url
        # tags
        election.root_election_tags.each do |election_tag|
          url = {}
          url[:loc] = compare_url election, candidacy.namespace, election_tag.tag.namespace
          url[:priority] = 0.9
          @urls << url
        end
      end
    end
  end
  
end