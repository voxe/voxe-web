class window.ElectionsCollection extends Backbone.Collection
  
  url: '/api/v1/elections/search'
  
  parse: (response)->
    response.elections