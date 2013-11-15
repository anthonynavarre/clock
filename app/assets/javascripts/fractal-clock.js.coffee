millisecondsPerMedian = 43200000 # 60*60*1000*12
millisecondsPerHour = 3600000 # 60*60*1000
millisecondsPerMinute = 60000 # 60*1000
millisecondsPerSecond = 1000

class FractalClock
  secHandLength = 300
  minHandLength = 230
  hrHandLength = 160

  constructor: ->
    @canvas = document.getElementById('clock')
    @context = @canvas.getContext('2d')
    @timeDisplay = new TimeDisplay(@context)
    @animatedNumber = new AnimatedNumber(@context)

    @animatedNumbers = {
      seconds: new AnimatedNumber(@context)
      minutes: new AnimatedNumber(@context)
      hours: new AnimatedNumber(@context)
    }

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
    @context.arc(0, 0, length, radians - .1, radians + .5, false)
    @context.stroke()
    @context.closePath()


  drawNumber: (number, length, angle, type) ->
    @context.save()
    @context.translate(length * Math.cos(angle), length * Math.sin(angle))
    @context.rotate(angle + @degreesToRadians(90))
    @animatedNumbers[type].drawNumber(number, type != 'hours')
    @context.restore()


  degreesToRadians: (degrees) ->
    degrees * (Math.PI / 180)


  drawClock: =>
    @clear()
    @updateTime()

    @context.save()
    @context.translate(-(@dimensions().x / 2) + 200, -(@dimensions().y / 2) + 100)
    #@timeDisplay.draw()
    #@animatedNumber.drawNumber(@seconds)
    @context.restore()

    millisecondsPastMinute = (@seconds * millisecondsPerSecond) + @milliseconds
    millisecondsPastHour   = (@minutes * millisecondsPerMinute) + millisecondsPastMinute
    millisecondsPastMedian = (@hours * millisecondsPerHour) + millisecondsPastHour

    secondHandAngle = 360 * (millisecondsPastMinute / millisecondsPerMinute)
    minuteHandAngle = 360 * (millisecondsPastHour / millisecondsPerHour)
    hourHandAngle   = 360 * (millisecondsPastMedian / millisecondsPerMedian)

    secondsRadAngle = @degreesToRadians(secondHandAngle - 90)
    minutesRadAngle = @degreesToRadians(minuteHandAngle - 90)
    hrRadAngle = @degreesToRadians(hourHandAngle - 90)

    @drawNumber(@hours, hrHandLength, hrRadAngle, 'hours')
    @drawNumber(@minutes, minHandLength, minutesRadAngle, 'minutes')
    @drawNumber(@seconds, secHandLength, secondsRadAngle, 'seconds')

    @maketifyHand(secHandLength, secondsRadAngle)
    @maketifyHand(minHandLength, minutesRadAngle)
    @maketifyHand(hrHandLength, hrRadAngle)

new FractalClock
