class Backoffice.Views.Election.Propositions.PropositionsList.PropositionView extends Backbone.View
  tagName: 'tr'
  template: JST['backoffice/templates/election/propositions/propositions_list/proposition']

  events:
    'click button.delete-proposition': 'delete'
    'click button.show-embeds': 'toggleEmbeds'
    'click button.show-text': 'toggleEmbeds'
    'submit .add-embed': 'addEmbed'

  initialize: ->
    @subSubTag = @options.subSubTag
    @model.bind "change:embeds",
      ->
        @render()
        @toggleEmbeds()
      @

  render: ->
    $(@el).html @template proposition: @model.toJSON()
    $('.embeds', @el).hide()
    $('.show-text', @el).hide()

    @model.embeds.each (embed) =>
      view = new Backoffice.Views.Election.Propositions.PropositionsList.EmbedItemView(model: embed, proposition: @model)
      viewEl = view.render().el
      $('ul.embeds', @el).append(viewEl)

    view = @
    $('.proposition-text', @el).editable(
      (value, setting) ->
        view.model.save {}, data: $.param(proposition: {text: value, tagIds: view.subSubTag.id})
        return value
      type: 'textarea'
      submit: 'OK'
    )

    @

  delete: ->
    if(confirm('Êtes vous sur de vouloir supprimer cette proposition ?'))
      view = @
      @model.destroy  complete: (response) ->
        view.model.trigger 'destroy', view.model if response.status == 200

  addEmbed: (event) ->
    event.preventDefault()
    form = $(event.target)
    @model.addEmbed($('input[name=url]', form).val(), $('input[name=title]', form).val())

  deleteEmbed: (event) ->
    propositionId = $(event.target).parent().parent().parent().parent().data().propositionId
    proposition = @propositions.find (proposition) -> proposition.id == propositionId
    embedId = $(event.target).parent().data().embedId
    proposition.removeEmbed(embedId)

  toggleEmbeds: ->
    $('.text', @el).toggle()
    $('.embeds', @el).toggle()
    $('.show-embeds', @el).toggle()
    $('.show-text', @el).toggle()
