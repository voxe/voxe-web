class window.ApplicationView extends Backbone.View
  
  events:
    "click .facebook": "facebook"
  
  initialize: ->
    @model.bind 'change', @setElectionName
    @width = $('#app').width()
    @height = $('#app').height()
    
  setElectionName: =>
    @.$('#header .container').html @model.name()
    
  render: ->
    $(@el).html Mustache.to_html($('#application-template').html(), election: @model.toJSON())
    @
    
  facebook: ->
    obj = {
      method: 'feed',
      link: 'http://voxe.org',
      picture: 'http://voxe.org/assets/iOS/114ios.png',
      name: "Voxe",
      caption: 'Voxe.org',
      description: 'Comparer les candidats avant de voter.'
    }

    FB.ui obj, (response)->
      if response['post_id']
        alert 'Envoye!'