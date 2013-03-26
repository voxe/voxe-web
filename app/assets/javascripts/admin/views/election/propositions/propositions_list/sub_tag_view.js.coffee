class Admin.Views.Election.Propositions.PropositionsList.SubTagView extends Backbone.View
  className: 'sub-tag'
  template: JST['admin/templates/election/propositions/propositions_list/sub_tag']

  initialize: ->
    @subTag = @model
    @propositionsByTag = @options.propositionsByTag
    @candidacy = @options.candidacy

  render: ->
    $(@el).html @template subTag: @subTag.toJSON()

    @subTag.tags.each @addSubSubTag, @

    @

  addSubSubTag: (subSubTag) ->
    view = new Admin.Views.Election.Propositions.PropositionsList.SubSubTagView(model: subSubTag, propositionsByTag: @propositionsByTag, candidacy: @candidacy)
    viewEl = view.render().el
    $(@el).append(viewEl)
