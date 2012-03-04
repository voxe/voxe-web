class Backoffice.Views.Election.Propositions.PropositionsList.PropositionsListView extends Backbone.View
  template: JST['backoffice/templates/election/propositions/propositions_list/propositions_list']

  initialize: ->
    @flash = {}
    @election = @options.election
    @candidacy = @election.candidacies.find ((candidacy) -> candidacy.id == @options.candidacy_id), @
    @tag = @election.tags.depthTagSearch @options.tag_id
    @tags = @tag.tags
    @propositions = new PropositionsCollection()
    @propositions.bind 'reset', @render, @
    @propositions.fetch({data: {electionId: @election.id, candidacyIds: @candidacy.id, tagIds: @tag.id}})

  render: ->
    @propositionsByTag = @propositions.reduce(
      (memo, proposition) ->
        _.each(proposition.get('tags'), (tagObject) ->
          tagId = tagObject.id
          memo[tagId] ||= new Array()
          memo[tagId].push proposition
        )
        memo
      {}
    )

    $(@el).html @template candidacy: @candidacy.toJSON()

    @tags.each @addSubTag, @

    $(@el).button()

    @

  addSubTag: (subTag) ->
    view = new Backoffice.Views.Election.Propositions.PropositionsList.SubTagView(model: subTag, propositionsByTag: @propositionsByTag, candidacy: @candidacy)
    viewEl = view.render().el
    $(@el).append(viewEl)
