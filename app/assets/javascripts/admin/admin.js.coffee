#= require jquery-ui
#= require jquery/jquery.tablednd
#= require jquery/jquery.jeditable.min
#= require underscore-1.2.0
#= require backbone-0.5.3
#= require bootstrap-1.3.0
#= require hamlcoffee

#= require_self
#= require_tree ../backbone/models
#= require_tree ../backbone/collections
#= require_tree ./templates
#= require_tree ./views

window.Admin =
  Views:
    Admins: {}
    Countries: {}
    Elections: {}
    Election:
      Propositions:
        Candidacies: {}
        Tags: {}
        PropositionsList: {}
  ViewInstances:
    Election: {}
  Cache: {}
  Router: Backbone.Router.extend(
    routes:
      '': 'index'
      'elections': 'elections'
      'elections/:id': 'election'
      'elections/:election_id/:menu_entry': 'election'
      'elections/:election_id/:menu_entry/candidacies/:candidacy_id': 'election'
      'elections/:election_id/:menu_entry/candidacies/:candidacy_id/tags/:id': 'election'
      'admins': 'admins'
      'countries': 'countries'

    index: ->
      @.navigate 'elections', true
    elections: ->
      if elections = Admin.Cache.elections
        new Admin.Views.ElectionsView(collection: elections).render()
      else
        elections = new ElectionsCollection()
        Admin.Cache.elections = elections
        new Admin.Views.ElectionsView(collection: elections)
        elections.fetch({data: published: 'all'})
    election: (election_id, menu_entry, candidacy_id = null, id = null) ->
      if menu_entry
        if Admin.ViewInstances.Election[election_id]
          Admin.ViewInstances.Election[election_id].go_to(
            menu_entry: menu_entry, reset: true, candidacy_id: candidacy_id, tag_id: id)
        else
          Admin.ViewInstances.Election[election_id] =
            new Admin.Views.ElectionView(
              election_id: election_id, menu_entry: menu_entry, candidacy_id: candidacy_id, tag_id: id)
      else
        console.error 'wrong route'
    admins: ->
      admins = new UsersCollection()
      new Admin.Views.Admins.AdminsView(collection: admins)
      admins.fetchAdmins()
    countries: ->
      countries = new CountriesCollection()
      new Admin.Views.Countries.CountriesView(collection: countries)
      countries.fetch()
  )

$ ->
  Admin.RouterInstance = new Admin.Router()

  $('a[data-backbone-link]').live 'click', (event) ->
    event.preventDefault()
    href = $(event.target).attr('href').slice(6) # get href and slice "admin/"
    Admin.RouterInstance.navigate href, true

  Backbone.history.start()
