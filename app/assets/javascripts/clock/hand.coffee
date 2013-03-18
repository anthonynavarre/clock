class App.Hand

  constructor: (context, boxWidth, color) ->
    [@context, @boxWidth, @color] = [context, boxWidth, color]

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
    @context.moveTo 0, 0
    @context.strokeStyle = @color
    @context.lineTo(@boxWidth * @length * Math.cos(@radians()), @boxWidth * @length * Math.sin(@radians()))

  degrees: -> #no-op
    throw new ReferenceError('#degrees method is an abstract method. You must implement it yourself')
