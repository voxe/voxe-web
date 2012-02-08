class Backoffice.Views.Election.CandidaciesView extends Backbone.View
  template: JST['backoffice/templates/election/candidacies']

  events:
    'submit .add-candidate': 'addCandidate'
    'submit .create-candidate': 'createCandidate'

  initialize: ->
    @flash = {}
    @election = @model
    @candidacies = @election.candidacies
    @render()

  render: ->
    $(@el).html @template @
    $('button.hover', @el).hide()
    @candidacies.each @addCandidacy

    #autocomplete
    form = $('form.add-candidate', @el)
    $('.name', form).autocomplete
      source: (request, response) ->
        candidates = new CandidatesCollection()
        candidates.searchRequest = true
        candidates.bind 'reset', ->
          response @map (candidate) ->
            {label: candidate.toString(), value: candidate.id}
        candidates.search request.term
      focus: (event, ui) ->
        $('.name', form).val ui.item.label
        return false
      select: (event, ui) ->
        $('.name', form).val ui.item.label
        $('.id', form).val ui.item.value
        return false

    @flash = {}

  addCandidate: (event) ->
    event.preventDefault()
    form = $(event.target)
    candidate = {id: $('.id', form).val()}
    @election.addCandidate candidate

  createCandidate: (event) ->
    event.preventDefault()
    form = $(event.target)
    firstName = $('input.first-name', form).val()
    lastName = $('input.last-name', form).val()
    namespace = firstName + '-' + lastName
    candidate = new CandidateModel(first_name: firstName, last_name: lastName, namespace: namespace)
    election = @election
    candidate.save {}, success: (candidate) ->
      election.addCandidate candidate

  addCandidacy: (candidacy) ->
    view = new Backoffice.Views.Election.CandidacyItemView(model: candidacy)
    viewEl = view.render().el
    $('table.candidacies').append(viewEl)
