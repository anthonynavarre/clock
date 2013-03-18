#= require clock/hand
#= require clock/hands

class App.Clock

  level: 0
  constructor: (context, boxWidth, colors) ->
    [@context, @boxWidth, @colors] = [context, boxWidth, colors]

  handClasses: [App.HourHand, App.MinuteHand, App.SecondHand]

  draw: ->
    @_drawHands()
    @_drawSubClocks()

  _drawHands: ->
    @context.save()
    currentScaleFactor = @boxWidth / App.Dimensions.startingBoxWidth()
    @context.lineWidth = currentScaleFactor * App.STARTING_HAND_WIDTH
    i = 0
    @hands = (new Hand(@context, @boxWidth, @colors[i++]) for Hand in @handClasses)
    hand.draw() for hand in @hands
    @context.restore()

  _drawSubClocks: ->
    return if @level >= App.NUMBER_OF_LEVELS
    new App.SubClock(@context, @boxWidth * 0.66, hand, @level+1).draw() for hand in @hands
