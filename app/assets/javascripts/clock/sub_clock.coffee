#= require clock/clock

class App.SubClock extends App.Clock

  constructor: (context, boxWidth, sourceHand, level) ->
    [@sourceHand, @level] = [sourceHand, level]
    super

  handClasses: [App.MinuteHand, App.HourHand]

  draw: ->
    @context.save()
    @context.translate(@sourceHand.endPoint().x, @sourceHand.endPoint().y)
    @context.rotate(App.degreesToRadians(@sourceHand.degrees() - 180))
    @context.strokeStyle = @sourceHand.color
    @_drawHands()
    @_drawSubClocks()
    @context.restore()
