#= require jquery
#= require jquery_ujs
#= require turbolinks_hacked
#= require underscore
#= require backbone

class @Router extends Backbone.Router
  routes:
    '': 'toTop'
    'country-*': 'toElections'
    ':namespace': 'toCandidacies'
    ':namespace/:candidacies': 'toTags'
    ':namespace/:candidacies/:tag': 'toPropositions'
  toTop: ->
  toElections: -> @scrollTo('#elections')
  toCandidacies: -> @scrollTo('#candidacies')
  toTags: -> @scrollTo('#tags')
  toPropositions: -> @scrollTo('#comparison-page')
  scrollTo: (target) ->
    console.log target
    $('body').scrollTop($(target).offset().top)

$ ->
  new Router()
  Backbone.history.start(pushState: true, root: '/')

$(document).on 'page:change', ->
  Backbone.history.stop()
  Backbone.history.start()

class @CandidaciesSelectorView extends Backbone.View
  events:
    'click .candidacy': 'selectCandidacy'

  initialize: ->
    @selectedCandidacies = @options.selectedCandidacies
    _.map @selectedCandidacies, (candidacyNamespace) ->
      $("[data-candidacy-namespace=#{candidacyNamespace}]").addClass('selected')

  selectCandidacy: (e) ->
    if @selectedCandidacies.length >= 2
      @selectedCandidacies = []
      $('.candidacy').removeClass('selected')

    $target = $(e.currentTarget)
    namespace = $target.data().candidacyNamespace
    @selectedCandidacies.push namespace
    $target.addClass('selected')

    if @selectedCandidacies.length == 2
      Turbolinks.visit "/#{@options.electionNamespace}/#{@selectedCandidacies[0]},#{@selectedCandidacies[1]}"
