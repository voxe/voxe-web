class Backoffice.Views.Election.CandidaciesView extends Backbone.View
  template: JST['backoffice/templates/election/candidacies']

  initialize: ->
    @flash = {}
    @election = @model
    @candidacies = @election.candidacies
    @render()
    $('.add-candidate').submit (event) =>
      event.preventDefault()
      @addCandidate event
    $('.create-candidate').submit (even) =>
      event.preventDefault()
      @createCandidate event

    ambassadors_view = new Backoffice.Views.Election.AmbassadorsView(model: @election)
    $('#modal-ambassadors').on 'show', ->
      ambassadors_view.fetch_amabassadors()

    contributors_view = new Backoffice.Views.Election.ContributorsView(model: @election)
    $('#modal-contributors').on 'show', ->
      contributors_view.fetch_contributors()

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
    form = $(event.target)
    candidate = {id: $('.id', form).val()}
    @election.addCandidate candidate
    $('#modal-candidacies').modal('hide')

  createCandidate: (event) ->
    form = $(event.target)
    firstName = $('input.first-name', form).val()
    lastName = $('input.last-name', form).val()
    namespace = firstName + '-' + lastName
    candidate = new CandidateModel(first_name: firstName, last_name: lastName, namespace: namespace)
    election = @election
    candidate.save {}, success: (candidate) ->
      election.addCandidate candidate
      $('#modal-candidacies').modal('hide')

  addCandidacy: (candidacy) =>
    @candidacy = @election.candidacies.find ((candidacy) -> candidacy.id == @options.candidacy_id), @
    view = new Backoffice.Views.Election.CandidacyView(election: @election, model: candidacy)
    viewEl = view.render().el
    $('table.list').append(viewEl)
