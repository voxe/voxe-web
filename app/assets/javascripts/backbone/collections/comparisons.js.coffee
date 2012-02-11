class window.ComparisonsCollection extends Backbone.Collection

  parse: (response) ->
    response.response.comparisons.reverse()