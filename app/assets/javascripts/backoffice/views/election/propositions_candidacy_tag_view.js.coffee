class Backoffice.Views.Election.PropositionsCandidacyTagView extends Backbone.View
  template: JST['backoffice/templates/election/propositions_candidacy_tag']

  initialize: ->
    @election = @options.election
    @candidacy = @election.candidacies.find ((candidacy) -> candidacy.id == @options.candidacy_id), @
    @tag = @election.tags.depthTagSearch @options.tag_id
    @tags = @tag.tags
    @propositions = new PropositionsCollection()
    @propositions.bind 'reset', @render, @
    @propositions.fetch({data: {electionId: @election.id, candidacyIds: @candidacy.id, tagIds: @tag.id}})

  render: ->
    @propositions_by_tag = @propositions.reduce(
      (res, proposition) ->
        _.each proposition.get('tags'), (tag) ->
          res[tag.id] ||= new Array()
          res[tag.id].push(proposition)
        res
      {}
    )
    $(@el).html @template @
    $('table.sub_tags h3', @el).click ->
      parent_tag = $($(@).parent())
      sub_tag_id = parent_tag.attr('data-tag-id')
      $('.propositions', parent_tag).toggle()
    $('.propositions', @el).hide()


