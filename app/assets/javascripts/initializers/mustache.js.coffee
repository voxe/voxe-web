# Add a Mustache.js templating function to your JavaScript:

window.Mustache.template = (templateString) ->
  ->
    Mustache.to_html templateString, arguments[0], arguments[1]

# And then, in assets.yml, you can set "template_function" to "Mustache.template".