class App.Color

  @randomColorComponent = ->
    intColor = Math.round(Math.random() * 255)
    if intColor < 20 # don't allow dark colors since we're on a black background
      @randomColorComponent()
    else
      intColor.toString(16)

  @random: ->
    rgb = (@randomColorComponent() for i in [1..3]).join('')
    "##{rgb}"

  @darkGray: ->
    "#333"

  @gray: ->
    "#888"

  @black: ->
    "#000"
