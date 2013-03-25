class App.SecondHand extends App.Hand

  length: App.SEC_HAND_LENGTH_FACTOR
  degrees: ->
    360 * (@millisecondsPastMinute() / App.MILLISECONDS_PER_MINUTE)


class App.MinuteHand extends App.Hand

  length: App.MIN_HAND_LENGTH_FACTOR
  degrees: ->
    360 * (@millisecondsPastHour() / App.MILLISECONDS_PER_HOUR)


class App.HourHand extends App.Hand

  length: App.HR_HAND_LENGTH_FACTOR
  degrees: ->
    360 * (@millisecondsPastMedian() / App.MILLISECONDS_PER_MEDIAN)
