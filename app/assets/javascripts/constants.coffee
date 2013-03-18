do ->

  window.App = {}

  App.degreesToRadians = (degrees) ->
    degrees * (Math.PI / 180)

  App.padLeft = (string, padChar, length) ->
    return string if string.length == length
    App.padLeft "#{padChar}#{string}", padChar, length

  App.MILLISECONDS_PER_MEDIAN = 43200000 # 60*60*1000*12
  App.MILLISECONDS_PER_HOUR   = 3600000 # 60*60*1000
  App.MILLISECONDS_PER_MINUTE = 60000 # 60*1000
  App.MILLISECONDS_PER_SECOND = 1000

  App.SEC_HAND_LENGTH_FACTOR = 1.0
  App.MIN_HAND_LENGTH_FACTOR = 0.9
  App.HR_HAND_LENGTH_FACTOR  = 0.8
  App.INITIAL_SCALE_FACTOR = 0.6
  App.STARTING_HAND_WIDTH = 5

  App.NUMBER_OF_LEVELS = 8
  App.FRAMERATE = 24
