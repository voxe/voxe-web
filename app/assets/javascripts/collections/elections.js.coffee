class window.ElectionsCollection extends Backbone.Collection
  
  url: '/api/v1/elections'
  
  parse: (response)->
    response.elections