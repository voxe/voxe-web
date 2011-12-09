class window.ApplicationView extends Backbone.View
  
  events:
    "click #toolbar": "candidatesClick"
      
  candidatesClick: (e)->
    app.router.navigate "candidates", true