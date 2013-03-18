class App.Hand

  constructor: (length, context) ->
    @drawn = false
    @length = length
    @context = context

    @now = new Date()
    @milliseconds = @now.getMilliseconds()
    @seconds = @now.getSeconds()
    @minutes = @now.getMinutes()
    @hours = @now.getHours()

  millisecondsPastMinute: ->
    (@seconds * App.MILLISECONDS_PER_SECOND) + @milliseconds

  millisecondsPastHour: ->
    (@minutes * App.MILLISECONDS_PER_MINUTE) + @millisecondsPastMinute()

  millisecondsPastMedian: ->
    (@hours * App.MILLISECONDS_PER_HOUR) + @millisecondsPastHour()

  endPoint: ->
    x: @length * Math.cos(@radians())
    y: @length * Math.sin(@radians())

  radians: ->
    App.degreesToRadians(@degrees() - 90)

  draw: ->
    @context.beginPath()

    @context.moveTo 0, 0
    @context.lineTo(@length * Math.cos(@radians()), @length * Math.sin(@radians()))

    @context.stroke()
    @context.closePath()
    @drawn = true

  degrees: -> #no-op
    throw new ReferenceError('#degrees method is an abstract method. You must implement it yourself')
