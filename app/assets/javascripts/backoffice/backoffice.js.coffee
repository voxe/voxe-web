#= require jquery-ui
#= require ../libs/underscore-1.2.0
#= require ../libs/backbone-0.5.3
#= require_tree ../libs/bootstrap-1.3.0
#= require jquery.jeditable.min
#= require hamlcoffee
#= require jquery.tablednd
#= require_self
#= require_tree ../backbone/models
#= require_tree ../backbone/collections
#= require_tree ./templates
#= require_tree ./views

window.Backoffice =
  Views:
    Admins: {}
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

    index: ->
      @.navigate 'elections', true
    elections: ->
      if elections = Backoffice.Cache.elections
        new Backoffice.Views.ElectionsView(collection: elections).render()
      else
        elections = new ElectionsCollection()
        Backoffice.Cache.elections = elections
        new Backoffice.Views.ElectionsView(collection: elections)
        elections.fetch({data: published: 'all'})
    election: (election_id, menu_entry, candidacy_id = null, id = null) ->
      if menu_entry
        if Backoffice.ViewInstances.Election[election_id]
          Backoffice.ViewInstances.Election[election_id].go_to(
            menu_entry: menu_entry, reset: true, candidacy_id: candidacy_id, tag_id: id)
        else
          Backoffice.ViewInstances.Election[election_id] =
            new Backoffice.Views.ElectionView(
              election_id: election_id, menu_entry: menu_entry, candidacy_id: candidacy_id, tag_id: id)
      else
        console.error 'wrong route'
    admins: ->
      admins = new UsersCollection()
      new Backoffice.Views.Admins.AdminsView(collection: admins)
      admins.fetchAdmins()
  )

$ ->
  Backoffice.RouterInstance = new Backoffice.Router()

  $('a[data-backbone-link]').live 'click', (event) ->
    event.preventDefault()
    href = $(event.target).attr('href').slice(6) # get href and slice "admin/"
    Backoffice.RouterInstance.navigate href, true

  Backbone.history.start()
