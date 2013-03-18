class App.Hand

  constructor: (context, boxWidth) ->
    [@context, @boxWidth] = [context, boxWidth]

    @drawn = false
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
    x: @boxWidth * @length * Math.cos(@radians())
    y: @boxWidth * @length * Math.sin(@radians())

  radians: ->
    App.degreesToRadians(@degrees() - 90)

  draw: ->
    @context.beginPath()

    @context.moveTo 0, 0
    @context.lineTo(@boxWidth * @length * Math.cos(@radians()), @boxWidth * @length * Math.sin(@radians()))

    @context.stroke()
    @context.closePath()
    @drawn = true

  degrees: -> #no-op
    throw new ReferenceError('#degrees method is an abstract method. You must implement it yourself')
