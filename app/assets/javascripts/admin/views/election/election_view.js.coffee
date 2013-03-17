class Admin.Views.ElectionView extends Backbone.View
  el: '.content'
  template: JST['admin/templates/election/layout']
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
        new Admin.Views.Election.ContributorsView(el: @content_el, model: @election)
      when 'candidacies', 'propositions'
        new Admin.Views.Election.ShowView(el: @content_el, model: @election, candidacyId: @options.candidacy_id, tagId: @options.tag_id)
        new Admin.Views.Election.InformationsView(el: '.election-infos', model: @election)
      else
        console.error 'wrong route'
    $('.change-election').click ->
      Admin.RouterInstance.navigate 'elections', true

  go_to: (options) ->
    if options.reset
      @options = options
    else
      @options= _.extend @options, options
    @render()
