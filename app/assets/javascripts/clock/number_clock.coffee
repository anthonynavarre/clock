class App.NumberClock

  _fontAtSize = (size) ->
    "normal normal 100 #{size}pt Helvetica Neue"

  _position = ->
    [-(App.Dimensions.getDimensions().x / 2) + 15, App.Dimensions.getDimensions().y / 2 - 15]

  constructor: (context, colors) ->
    [@context, @colors] = [context, colors]
    @position = _position()

    @now = new Date()
    @milliseconds = "#{@now.getMilliseconds()}_"
    @seconds = App.padLeft(@now.getSeconds().toString(), "0", 2)
    @minutes = App.padLeft(@now.getMinutes().toString(), "0", 2)
    @hours = if @now.getHours() > 12
        @now.getHours() - 12
      else
        @now.getHours()


  draw: ->
    @context.save()
    @context.translate(@position...)

    @context.font = _fontAtSize(48)
    @drawNumber @hours, @colors[0]

    @context.font = _fontAtSize(36)
    @drawNumber @minutes, @colors[1]

    @context.font = _fontAtSize(24)
    @drawNumber @seconds, @colors[2]

    @context.font = _fontAtSize(18)
    @drawNumber @milliseconds, App.Color.darkGray(), false

    @context.restore()

  drawNumber: (text, color, suffix=true) ->
    text = "#{text}." if suffix
    @context.fillStyle = color
    @context.lineStyle = color
    @context.fillText(text, 0, 0)
    @context.translate(@context.measureText(text).width, 0)
