class Web::ComparisonsController < Web::ApplicationController
  before_filter :load_countries
  before_filter :load_elections
  before_filter :load_election
  before_filter :load_candidacies, if: ->{ params[:candidacies] }
  before_filter :load_tag, if: ->{ params[:tag] }
  before_filter :load_propositions, if: ->{ @candidacies and @tag }

  def compare
    @countries_with_upcoming_elections = @elections
  end

  protected
  def load_countries
    elections = Election.where(:country_id.ne => nil, :date.ne => nil)
    @countries = { with_upcoming_elections: Set.new, with_past_elections: Set.new }
    @countries = elections.reduce(@countries) do |countries, election|
      if election.upcoming?
        countries[:with_upcoming_elections] << election.country
      else
        countries[:with_past_elections] << election.country
      end
      countries
    end
  end

  def load_elections
    unless @country = Country.where(namespace: params[:country_namespace]).first
      @country = @election.country if load_election
    end
    if @country.present?
      @elections = @country.elections
    else
      @elections = []
    end
  end

  def load_election
    @election ||= Election.where(namespace: params[:namespace]).first
  end

  def load_candidacies
    @candidates = Candidate.where(:namespace.in => params[:candidacies].split(','))
    @candidacies = Candidacy.where(election_id: @election, :candidate_ids.in => @candidates.map(&:id))
  end

  def load_tag
    @tag = Tag.where(namespace: params[:tag]).first
  end

  def load_propositions
    @propositions = Proposition.where(:candidacy_id.in => @candidacies.map(&:id), tag_ids: @tag.id)

    # group propostions
    @groupedPropositions = ElectionTag.where(election_id: @election.id, tag_id: @tag.id).first.children_election_tags.reduce({}) do |memo, election_tag|
      memo[election_tag.tag] = election_tag.children_election_tags.reduce({}) do |memo2, et2|
        memo2[et2.tag] = @candidacies.reduce({}) do |memo3, candidacy|
          memo3[candidacy] = @propositions.select do |p|
            p.tags.include?(et2.tag) && p.candidacy == candidacy
          end
          memo3
        end
        memo2
      end
      memo
    end
  end
end
