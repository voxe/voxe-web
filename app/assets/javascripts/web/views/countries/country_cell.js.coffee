class window.CountryCellView extends Backbone.View

  events:
    "click": "countryClick"
    
  countryClick: (e)->
    app.router.navigate "country-" + @model.namespace, true
    true
      
  render: ->
    $(@el).html Mustache.to_html($('#country-cell-template').html(), country: @model)
    $(@el).fadeIn 500
    @
