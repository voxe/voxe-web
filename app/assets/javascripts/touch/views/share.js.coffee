class window.ShareView extends Backbone.View

  events:
    "click a.close": "closeClick"
    "click .facebook": "facebook"
    
  closeClick: ->
    app.views.application.dissmissModalView()
    
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
        
  render: ->
    $(@el).html Mustache.to_html($('#share-template').html())
    @