class window.MenuCountryView extends Backbone.View
  
  tagName: 'li'
  className: 'country'
  
  initialize: ->
    @collection.bind "filter:country", @render, @
    
  events:
    "click": "goToPage"
    
  goToPage: ->
    app.router.navigate "/", true
    
  render: ->
    if @collection.selectedCountry
      $(@el).html Mustache.to_html($('#menu-country-template').html(), country: @collection.selectedCountry)
      $(@el).fadeIn()
    @
