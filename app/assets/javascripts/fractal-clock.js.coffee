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
    # @context.font = '24pt Helvetica'

    @bindResizeEvents()

    @drawCanvas()
    @beginClock()


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
    @context.moveTo(0, 0)

    @context.lineTo(length * Math.cos(radians), length * Math.sin(radians))

    @context.stroke()
    @context.closePath()

    @context.beginPath()
    @context.arc(0, 0, length, radians - .1, radians + .1, false)
    @context.stroke()
    @context.closePath()


  drawNumber: (number, length, angle, size) ->
    @context.save()
    @context.font="#{size}pt Helvetica"
    @context.translate(length * Math.cos(angle), length * Math.sin(angle))
    @context.rotate(angle + @degreesToRadians(90))
    @context.fillText(number, -25, 0)
    @context.restore()


  degreesToRadians: (degrees) ->
    degrees * (Math.PI / 180)


  drawClock: =>
    @clear()
    @updateTime()

    millisecondsPastMinute = (@seconds * millisecondsPerSecond) + @milliseconds
    millisecondsPastHour   = (@minutes * millisecondsPerMinute) + millisecondsPastMinute
    millisecondsPastMedian = (@hours * millisecondsPerHour) + millisecondsPastHour

    secondHandAngle = 360 * (millisecondsPastMinute / millisecondsPerMinute)
    minuteHandAngle = 360 * (millisecondsPastHour / millisecondsPerHour)
    hourHandAngle   = 360 * (millisecondsPastMedian / millisecondsPerMedian)

    radAngle = @degreesToRadians(secondHandAngle - 90)
    @maketifyHand(secHandLength, radAngle)
    @drawNumber(@seconds, secHandLength, radAngle, 52)

    radAngle = @degreesToRadians(minuteHandAngle - 90)
    @maketifyHand(minHandLength, radAngle)
    @drawNumber(@minutes, minHandLength, radAngle, 31)

    radAngle = @degreesToRadians(hourHandAngle - 90)
    @maketifyHand(hrHandLength, radAngle)
    @drawNumber(@hours, hrHandLength, radAngle, 24)














new FractalClock


