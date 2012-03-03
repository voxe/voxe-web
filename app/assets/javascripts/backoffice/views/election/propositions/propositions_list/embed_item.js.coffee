class Backoffice.Views.Election.Propositions.PropositionsList.EmbedItemView extends Backbone.View
  tagName: 'li'
  template: JST['backoffice/templates/election/propositions/propositions_list/embed_item']

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
