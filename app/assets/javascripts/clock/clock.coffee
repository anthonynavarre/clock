#= require clock/hand
#= require clock/hands

class App.Clock

  level: 0
  constructor: (context, boxWidth, colors) ->
    [@context, @boxWidth, @colors] = [context, boxWidth, colors]

  handClasses: [App.HourHand, App.MinuteHand, App.SecondHand]

  draw: ->
    i = 0
    for Hand in @handClasses
      hand = new Hand(@context, @boxWidth, @colors[i++])
      hand.draw()
      return if @level >= App.NUMBER_OF_LEVELS
      new App.SubClock(@context, @boxWidth * 0.66, hand, @level+1).draw()
