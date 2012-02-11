class window.ComparisonView extends Backbone.View
  
  className: "comparison"
    
  render: ->
    $(@el).html Mustache.to_html($('#comparison-template').html(), comparison: @model.toJSON())
    @