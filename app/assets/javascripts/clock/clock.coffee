class App.Clock

  constructor: (context, boxWidth) ->
    [@context, @boxWidth] = [context, boxWidth]


  draw: ->
    new App.SecondHand(@context, @boxWidth).draw()
    new App.MinuteHand(@context, @boxWidth).draw()
    new App.HourHand(@context, @boxWidth).draw()
