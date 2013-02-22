class Backoffice.Views.ElectionView extends Backbone.View
  el: '.content'
  template: JST['backoffice/templates/election/layout']
  content_el: '.election-content'

  initialize: ->
    @election = new ElectionModel(id: @options.election_id)
    @election.bind 'change', @render, @
    @election.fetch(data: {tags: 'all', published: 'all'})

  render: () ->
    menu_entry = @options.menu_entry
    $(@el).html @template election: @election
    switch menu_entry
      when 'contributors'
        new Backoffice.Views.Election.ContributorsView(el: @content_el, model: @election)
      when 'candidacies', 'propositions'
        new Backoffice.Views.Election.ShowView(el: @content_el, model: @election, candidacyId: @options.candidacy_id, tagId: @options.tag_id)
        new Backoffice.Views.Election.InformationsView(el: '.election-infos', model: @election)
      else
        console.error 'wrong route'
    $('.change-election').click ->
      Backoffice.RouterInstance.navigate 'elections', true

  go_to: (options) ->
    if options.reset
      @options = options
    else
      @options= _.extend @options, options
    @render()
