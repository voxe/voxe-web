#= require jquery-ui
#= require ../libs/underscore-1.2.0
#= require ../libs/backbone-0.5.3
#= require_tree ../libs/bootstrap-1.3.0
#= require jquery.jeditable.min
#= require hamlcoffee
#= require_self
#= require_tree ../backbone/models
#= require_tree ../backbone/collections
#= require_tree ./templates
#= require_tree ./views

window.Backoffice =
  Views:
    Elections: {}
    Election: {}
  ViewInstances:
    Election: {}
  Cache: {}
  Router: Backbone.Router.extend(
    routes:
      '': 'index'
      'elections': 'elections'
      'elections/:id': 'election'
      'elections/:election_id/:menu_entry': 'election'
      'elections/:election_id/tags/:id': 'tags'
      'elections/:election_id/propositions/candidacies/:id': 'propositions_candidacy_tags'
      'elections/:election_id/propositions/candidacies/:candidacy_id/tags/:id': 'propositions_candidacy_tag'

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
    election: (id, menu_entry) ->
      if menu_entry
        if Backoffice.ViewInstances.Election[id]
          Backoffice.ViewInstances.Election[id].go_to(menu_entry: menu_entry, reset: true)
        else
          Backoffice.ViewInstances.Election[id] = new Backoffice.Views.ElectionView(election_id: id, menu_entry: menu_entry)
      else
        console.error 'wrong route'
    tags: (election_id, tag_id) ->
      if Backoffice.ViewInstances.Election[election_id]
        Backoffice.ViewInstances.Election[election_id].go_to menu_entry: 'tags', tag_id: tag_id
      else
        Backoffice.ViewInstances.Election[election_id] = new Backoffice.Views.ElectionView(election_id: election_id, menu_entry: 'tags', tag_id: tag_id)
    propositions_candidacy_tags: (election_id, candidacy_id) ->
      if Backoffice.ViewInstances.Election[election_id]
        Backoffice.ViewInstances.Election[election_id].go_to menu_entry: 'propositions_candidacy_tags', candidacy_id: candidacy_id
      else
        Backoffice.ViewInstances.Election[election_id] = new Backoffice.Views.ElectionView(election_id: election_id, menu_entry: 'propositions_candidacy_tags', candidacy_id: candidacy_id)
    propositions_candidacy_tag: (election_id, candidacy_id, tag_id) ->
      if Backoffice.ViewInstances.Election[election_id]
        Backoffice.ViewInstances.Election[election_id].go_to menu_entry: 'propositions_candidacy_tag', candidacy_id: candidacy_id, tag_id: tag_id
      else
        Backoffice.ViewInstances.Election[election_id] = new Backoffice.Views.ElectionView(election_id: election_id, menu_entry: 'propositions_candidacy_tag', candidacy_id: candidacy_id, tag_id: tag_id)
  )

$ ->
  Backoffice.RouterInstance = new Backoffice.Router()
  Backbone.history.start()
