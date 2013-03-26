class Admin.Views.Election.Propositions.PropositionsList.EmbedItemView extends Backbone.View
  tagName: 'li'
  template: JST['admin/templates/election/propositions/propositions_list/embed_item']

  events:
    'click .delete': 'delete'

  initialize: ->
    @proposition = @options.proposition

  render: ->
    $(@el).html @template @model.toJSON()

    @

  delete: (event) ->
    event.preventDefault()
    @proposition.removeEmbed @model.id
