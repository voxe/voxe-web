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
    @propositionsBySubTag = @propositions.reduce(
      (res, proposition) ->
        subSubTagId = proposition.get('tags')[0].id
        subSubTag = @election.tags.depthTagSearch subSubTagId

        subTag = subSubTag.parent()

        res[subTag.id][subSubTagId].add proposition

        res
      @tags.reduce(
        (res, tag) ->
          res[tag.id] = tag.tags.reduce(
            (res, subTag) ->
              res[subTag.id] = new PropositionsCollection()
              res
            {}
          )
          res
        {}
      )
      @
    )

    $(@el).html @template candidacy: @candidacy.toJSON()

    @tags.each @addSubTag, @

    $(@el).button()

    @

  addSubTag: (subTag) ->
    view = new Backoffice.Views.Election.Propositions.PropositionsList.SubTagView(model: subTag, propositionsBySubSubTag: @propositionsBySubTag[subTag.id], candidacy: @candidacy)
    viewEl = view.render().el
    $(@el).append(viewEl)
