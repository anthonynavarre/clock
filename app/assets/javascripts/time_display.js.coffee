class TimeDisplay

  constructor: (context) ->
    @context = context
    now = new Date()
    @seconds = now.getSeconds()
    @minutes = now.getMinutes()
    @hours = now.getHours()

    @positions = {
      hours: 0
      minutes: 130
      seconds: 290
    }

    @representations = {
      hours: (num) -> twelveHour(num)
      minutes: (num) -> toDoubleDigit(num)
      seconds: (num) -> toDoubleDigit(num)
    }

    @separatorXValues = [108, 268]


  draw: ->
    @context.save()

    now = new Date()
    currSeconds = now.getSeconds()
    currMinutes = now.getMinutes()
    currHours   = now.getHours()

    @context.font="84pt Helvetica-Bold"
    @drawNumber(time) for time in ['hours', 'minutes', 'seconds']
    @drawSeparator(index) for index in [0..1]

    @seconds = currSeconds
    @minutes = currMinutes
    @hours = currHours

    @context.restore()

  drawNumber: (type) ->
    x = @positions[type]
    actualNumber = @[type]
    numToDraw = @representations[type](actualNumber)
    @context.fillText(numToDraw, x, 0)

  drawSeparator: (index) ->
    @context.fillRect(@separatorXValues[index], -50, 8, 8)
    @context.fillRect(@separatorXValues[index], -25, 8, 8)

  toDoubleDigit = (number, pad='0') ->
    numstr = number.toString()
    return "#{pad}#{numstr}" if numstr.length == 1
    numstr

  twelveHour = (number) ->
    num = if number > 12 then number - 12 else number
    toDoubleDigit(num, " ")

window.TimeDisplay = TimeDisplay
