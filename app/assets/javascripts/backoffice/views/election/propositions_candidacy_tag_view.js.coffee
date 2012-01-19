class Backoffice.Views.Election.PropositionsCandidacyTagView extends Backbone.View
  template: JST['backoffice/templates/election/propositions_candidacy_tag']

  events:
    'click button.show-proposition-form': 'showPropositionForm'
    'submit .add-proposition': 'addProposition'

  initialize: ->
    @flash = {}
    @election = @options.election
    @candidacy = @election.candidacies.find ((candidacy) -> candidacy.id == @options.candidacy_id), @
    @tag = @election.tags.depthTagSearch @options.tag_id
    @tags = @tag.tags
    @propositions = new PropositionsCollection()
    @propositions.bind 'reset', @render, @
    @propositions.bind 'add', @render, @
    @propositions.fetch({data: {electionId: @election.id, candidacyIds: @candidacy.id, tagIds: @tag.id}})

  render: ->
    @propositions_by_tag = @propositions.reduce(
      (res, proposition) ->
        _.each proposition.get('tags'), (tag) ->
          res[tag.id] ||= new Array()
          res[tag.id].push(proposition)
        res
      {}
    )
    $(@el).html @template @
    $('form.add-proposition', @el).hide()
    $(@el).button()

    view = @
    $('.proposition-text').editable(
      (value, setting) ->
        console.log @
        console.log value
        console.log setting

        propositionId = $(@).parent().data().propositionId
        proposition = view.propositions.find (proposition) -> proposition.id == propositionId
        console.log proposition
        console.log proposition.save {}, data: $.param(proposition: {text: value})

        return value
      type: 'textarea'
      submit: 'OK'
    )

    @falsh = {}

  showPropositionForm: (event) ->
    button = $(event.target)
    button.button('toggle')
    sub_tag_div = button.parent().parent()
    if $('form', sub_tag_div).toggle().is(':visible')
      button.button('mask')
    else
      button.button('reset')

  addProposition: (event) ->
    event.preventDefault()
    params = text: event.target.text.value
    params['tagIds'] = $(event.target).parent().data().tagId
    params['candidacyId'] = @candidacy.id
    @propositions.create params, url: '/api/v1/propositions', type: 'POST'
