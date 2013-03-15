class Admin.Views.Election.Propositions.PropositionsList.SubSubTagView extends Backbone.View
  className: 'sub-sub-tag'
  template: JST['admin/templates/election/propositions/propositions_list/sub_sub_tag']

  events:
    'click button.show-proposition-form': 'showPropositionForm'
    'submit .add-proposition': 'createProposition'

  initialize: ->
    @subSubTag = @model
    @propositionsByTag = @options.propositionsByTag
    @propositions = new PropositionsCollection(@propositionsByTag[@subSubTag.id])
    @candidacy = @options.candidacy
    @propositions.bind 'remove', @render, @
    @propositions.bind 'add', @render, @
    @propositions.bind 'destroy',
      (proposition) ->
        @remove proposition


  render: ->
    $(@el).html @template subSubTag: @subSubTag.toJSON(), propositions: not @propositions.isEmpty()
    $('form.add-proposition', @el).hide()

    @propositions.each @addProposition, @

    @

  addProposition: (proposition) ->
    view = new Admin.Views.Election.Propositions.PropositionsList.PropositionView(model: proposition, subSubTag: @subSubTag, candidacy: @candidacy)
    viewEl = view.render().el
    $('table.propositions', @el).append(viewEl)

  showPropositionForm: (event) ->
    button = $(event.target)
    button.button('toggle')
    sub_tag_div = button.parent().parent()
    if $('form', sub_tag_div).toggle().is(':visible')
      button.button('mask')
    else
      button.button('reset')

  createProposition: (event) ->
    event.preventDefault()
    params = text: event.target.text.value
    params['tagIds'] = @subSubTag.id
    params['candidacyId'] = @candidacy.id
    @propositions.create {proposition: params }, url: '/api/v1/propositions', type: 'POST'
