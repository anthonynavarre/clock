class App.SecondHand extends App.Hand

  degrees: ->
    360 * (@millisecondsPastMinute() / App.MILLISECONDS_PER_MINUTE)


class App.MinuteHand extends App.Hand

  degrees: ->
    360 * (@millisecondsPastHour() / App.MILLISECONDS_PER_HOUR)


class App.HourHand extends App.Hand

  degrees: ->
    360 * (@millisecondsPastMedian() / App.MILLISECONDS_PER_MEDIAN)
