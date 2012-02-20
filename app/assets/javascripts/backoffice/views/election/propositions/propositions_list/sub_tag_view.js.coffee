class Backoffice.Views.Election.Propositions.PropositionsList.SubTagView extends Backbone.View
  className: 'sub-tag'
  template: JST['backoffice/templates/election/propositions/propositions_list/sub_tag']

  initialize: ->
    @subTag = @model
    @propositionsBySubSubTag = @options.propositionsBySubSubTag
    @candidacy = @options.candidacy

  render: ->
    $(@el).html @template subTag: @subTag.toJSON()

    @subTag.tags.each @addSubSubTag, @

    @

  addSubSubTag: (subSubTag) ->
    view = new Backoffice.Views.Election.Propositions.PropositionsList.SubSubTagView(model: subSubTag, propositions: @propositionsBySubSubTag[subSubTag.id], candidacy: @candidacy)
    viewEl = view.render().el
    $(@el).append(viewEl)
