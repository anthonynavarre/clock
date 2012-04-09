millisecondsPerMedian = 43200000 # 60*60*1000*12
millisecondsPerHour = 3600000 # 60*60*1000
millisecondsPerMinute = 60000 # 60*1000
millisecondsPerSecond = 1000

class FractalClock
  secHandLength = 260
  minHandLength = 250
  hrHandLength = 150

  constructor: ->
    @canvas = document.getElementById('clock')
    @context = @canvas.getContext('2d')

    @bindResizeEvents()

    @drawCanvas()
    @setDefaults()

    @beginClock()


  setDefaults: ->
    @iterations = 14
    @context.strokeStyle = '#fff'


  dimensions: ->
    x: document.documentElement.clientWidth - 8
    y: document.documentElement.clientHeight - 20


  bindResizeEvents: ->
    window.onresize = @drawCanvas


  drawCanvas: =>
    @canvas.setAttribute('width', @dimensions().x)
    @canvas.setAttribute('height', @dimensions().y)
    @context.translate(@dimensions().x / 2, @dimensions().y / 2)

    @drawClock()


  beginClock: ->
    setInterval(@drawClock, 25)


  clear: ->
    @context.clearRect -(@canvas.width / 2), -(@canvas.height / 2), @canvas.width, @canvas.height


  updateTime: ->
    now = new Date()
    @milliseconds = now.getMilliseconds()
    @seconds = now.getSeconds()
    @minutes = now.getMinutes()
    @hours = now.getHours()


  maketifyHand: (length, radians) ->
    @context.beginPath()

    @context.moveTo 0, 0
    @context.lineTo(length * Math.cos(radians), length * Math.sin(radians))

    @context.stroke()
    @context.closePath()


  degreesToRadians: (degrees) ->
    degrees * (Math.PI / 180)


  drawClock: (iteration) =>
    @clear()
    @updateTime()

    millisecondsPastMinute = (@seconds * millisecondsPerSecond) + @milliseconds
    millisecondsPastHour   = (@minutes * millisecondsPerMinute) + millisecondsPastMinute
    millisecondsPastMedian = (@hours * millisecondsPerHour) + millisecondsPastHour

    secondHandAngle = 360 * (millisecondsPastMinute / millisecondsPerMinute)
    secondRadAngle  = @degreesToRadians(secondHandAngle - 90)

    minuteHandAngle = 360 * (millisecondsPastHour / millisecondsPerHour)
    minuteRadAngle  = @degreesToRadians(minuteHandAngle - 90)

    hourHandAngle   = 360 * (millisecondsPastMedian / millisecondsPerMedian)
    hourRadAngle    = @degreesToRadians(hourHandAngle - 90)

    @context.save()
    for iteration in [1..@iterations]
      # cycle even / odd
      sign = if((iteration % 2) == 0) then -1 else 1

      if iteration == 1
        [x, y] = [0, 0]
      else
        switch(iteration % 3)
          when 0
            originRadians = secondRadAngle
            originLength  = secHandLength
          when 1
            originRadians = minuteRadAngle
            originLength  = minHandLength
          else
            originRadians = hourRadAngle
            originLength  = hrHandLength

        x = originLength * Math.cos(originRadians)
        y = originLength * Math.sin(originRadians)

      @context.translate x, y
      @context.rotate hourRadAngle

      adjustedHrLength = hrHandLength - (iteration / @iterations)
      adjustedMinLength = minHandLength - (iteration / @iterations)
      adjustedSecLength = secHandLength - (iteration / @iterations)

      @maketifyHand adjustedHrLength, hourRadAngle
      @maketifyHand adjustedMinLength, minuteRadAngle
      @maketifyHand adjustedSecLength, secondRadAngle

    @context.restore()


new FractalClock

