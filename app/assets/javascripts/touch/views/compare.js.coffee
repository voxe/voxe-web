class window.CompareView extends Backbone.View

  tag: ->
    app.models.tag
    
  initialize: ->
    app.models.tag.bind "change", @changeTag, @
    
  events:
    "click a.nav": "themesClick"
    "click a.share": "facebook"
    
  themesClick: ->
    app.router.themesList()
    
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
    
  changeTag: ->
    $(".title", @el).html @tag().name()
    
  render: ->
    $(@el).html Mustache.to_html($('#compare-template').html(), tag: @tag())