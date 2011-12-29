#= require ../libs/underscore-1.2.0
#= require ../libs/backbone-0.5.3
#= require_tree ../libs/bootstrap-1.3.0
#= require_self
#= require_tree ../backbone/models
#= require_tree ../backbone/collections
#= require_tree ./templates
#= require_tree ./views

window.Backoffice =
  Views: {}
  Router: Backbone.Router.extend(
    routes:
      '': 'index'
      'countries': 'countries'
      'elections': 'elections'

    index: ->
      @.navigate 'countries', true
    countries: ->
      new Backoffice.Views.CountriesView()
    elections: ->
      new Backoffice.Views.ElectionsView()
  )


@remove_fields = (link) ->
  $(link).prev("input[type=hidden]").val("1")
  $(link).closest(".fields").hide()

@add_fields = (link, association, content) ->
  new_id = new Date().getTime()
  regexp = new RegExp("new_" + association, "g")
  $(link).parent().before(content.replace(regexp, new_id))

$ ->
  # $(".tabs").tabs()

  # Setup Backbone !
  backoffice = new Backoffice.Router()

  $('.backbone-link').live 'click', (e) ->
    e.preventDefault()
    backoffice.navigate $(@).attr('data-path'), true

  Backbone.history.start()
