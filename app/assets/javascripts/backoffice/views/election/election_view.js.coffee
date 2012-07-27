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
    unless menu_entry == "index"
      new Backoffice.Views.Election.ElectionMenuView(model: @election, menu_entry: menu_entry)
    switch menu_entry
      when 'index'
        new Backoffice.Views.Election.IndexView(el: @content_el, model: @election)
      when 'informations'
        new Backoffice.Views.Election.InformationsView(el: @content_el, model: @election)
      when 'contributors'
        new Backoffice.Views.Election.ContributorsView(el: @content_el, model: @election)
      when 'candidacies'
        new Backoffice.Views.Election.CandidaciesView(el: @content_el, model: @election)
      when 'tags'
        new Backoffice.Views.Election.TagsView(el: @content_el, election: @election, tag_id: @options.tag_id)
      when 'propositions'
        new Backoffice.Views.Election.Propositions.Candidacies.CandidaciesView(el: @content_el, model: @election)
      when 'propositions_candidacy_tags'
        new Backoffice.Views.Election.Propositions.Tags.TagsView(el: @content_el, election: @election,  candidacy_id: @options.candidacy_id)
      when 'propositions_candidacy_tag'
        new Backoffice.Views.Election.Propositions.PropositionsList.PropositionsListView(el: @content_el, election: @election,  candidacy_id: @options.candidacy_id, tag_id: @options.tag_id)
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
