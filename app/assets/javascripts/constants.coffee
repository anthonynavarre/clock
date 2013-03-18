do ->

  window.App = {}

  App.degreesToRadians = (degrees) ->
    degrees * (Math.PI / 180)

  App.MILLISECONDS_PER_MEDIAN = 43200000 # 60*60*1000*12
  App.MILLISECONDS_PER_HOUR   = 3600000 # 60*60*1000
  App.MILLISECONDS_PER_MINUTE = 60000 # 60*1000
  App.MILLISECONDS_PER_SECOND = 1000

  App.SEC_HAND_LENGTH = 260
  App.MIN_HAND_LENGTH = 250
  App.HR_HAND_LENGTH  = 150