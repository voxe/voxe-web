class window.ComparisonsListView extends Backbone.View
  
  initialize: ->
    @collection.bind "add", @add, @
    
  add: (comparison)->
    view = new ComparisonView model: comparison
    $(@el).prepend view.render().el
    $(view.el).slideDown()
    
  render: =>
    unless _.isEmpty @collection.models
      timestamp = _.last(@collection.models).get 'createdAt'
    else
      timestamp = ''
    @collection.fetch url: "/api/v1/comparisons/search", data: {afterTimestamp: timestamp}, add: true, success: =>
      setTimeout @render, 5000
    @