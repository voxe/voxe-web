class window.ComparisonView extends Backbone.View
    
  initialize: (options) ->
    # election
    @election = options.election
    # propositions
    @propositions = new PropositionsCollection()
    @propositions.bind "reset", @render, @
    
  tag: ->
    @election.tags.selected()
    
  candidacies: ->
    @election.candidacies.selected()
    
  groupedPropositions: ->
    hash = {}
    _.each @propositions.models, (proposition) ->
      candidacy = proposition.candidacy()
      _.each proposition.tags(), (tag) ->
        hash[tag.id] = {} unless hash[tag.id]
        hash[tag.id][candidacy.id] = [] unless hash[tag.id][candidacy.id]
        hash[tag.id][candidacy.id].push proposition
    hash
    
  fetchPropositions: ->
    $(@el).html ''
    
    if @candidacies().length == 2 && @tag()?
      # tag
      $(@el).append Mustache.to_html($('#comparison-template').html(), tag: @tag().toJSON())
      
      # @collection.reset ''
      candidacyIds = _.map @candidacies().models, (candidate) ->
           candidate.id
      candidacyIds = candidacyIds.join ','
      @propositions.fetch data: {electionIds: @election.id, tagIds: @tag().id, candidacyIds: candidacyIds}
    
  render: ->
    @.$(".indicator").fadeOut()
    
    # tags
    _.each @tag().tags.models, (tag) =>
      view = new ComparisonTagView(tag: tag, candidacies: @candidacies(), propositions: @groupedPropositions())
      $(@el).append view.render().el
        
    @