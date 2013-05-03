@app.factory 'Election', () ->
  class Election
    date: null

    constructor: (attributes) ->
      Object.keys(attributes).forEach (key) =>
        @[key] = switch key
          when 'date' then new Date(attributes[key])
          else attributes[key]

    isUpcoming: ->
      @date > new Date()

    isPast: -> not @isUpcoming()
