millisecondsPerMedian = 43200000 # 60*60*1000*12
millisecondsPerHour = 3600000 # 60*60*1000
millisecondsPerMinute = 60000 # 60*1000
millisecondsPerSecond = 1000


window.degreesToRadians = (degrees) ->
  degrees * (Math.PI / 180)


class Hand

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
    (@seconds * millisecondsPerSecond) + @milliseconds

  millisecondsPastHour: ->
    (@minutes * millisecondsPerMinute) + @millisecondsPastMinute()

  millisecondsPastMedian: ->
    (@hours * millisecondsPerHour) + @millisecondsPastHour()

  endPoint: ->
    x: @length * Math.cos(@radians())
    y: @length * Math.sin(@radians())

  radians: ->
    degreesToRadians(@degrees() - 90)

  draw: ->
    @context.beginPath()

    @context.moveTo 0, 0
    @context.lineTo(@length * Math.cos(@radians()), @length * Math.sin(@radians()))

    @context.stroke()
    @context.closePath()
    @drawn = true

  degrees: -> #no-op
    throw new ReferenceError('#degrees method is an abstract method. You must implement it yourself')


class SecondHand extends Hand

  degrees: ->
    360 * (@millisecondsPastMinute() / millisecondsPerMinute)


class MinuteHand extends Hand

  degrees: ->
    360 * (@millisecondsPastHour() / millisecondsPerHour)


class HourHand extends Hand

  degrees: ->
    360 * (@millisecondsPastMedian() / millisecondsPerMedian)


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
    @iterations = 4
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
    @hands = []
    @context.clearRect -(@canvas.width / 2), -(@canvas.height / 2), @canvas.width, @canvas.height


  drawClock: =>
    @clear()

    @addHand new SecondHand(secHandLength, @context)
    @addHand new MinuteHand(minHandLength, @context)
    @addHand new HourHand(hrHandLength, @context)


  addHand: (hand, iteration=1) ->
    @context.save()
    hand.draw()

    if (iteration >= @iterations) || (hand instanceof HourHand)
      @context.restore()
      return

    tmpHourHand = new HourHand(0)

    endPoint = hand.endPoint()
    @context.translate endPoint.x, endPoint.y
    @context.rotate degreesToRadians(180 - (tmpHourHand.degrees() - hand.degrees()))

    iteration++
    for i in[iteration..@iterations]
      adjustment = ((100 - i*3) / 100)

      adjustedHrLength  = hrHandLength  * adjustment
      adjustedMinLength = minHandLength * adjustment
      adjustedSecLength = secHandLength * adjustment

      @addHand(new SecondHand(adjustedSecLength, @context), i)
      @addHand(new MinuteHand(adjustedMinLength, @context), i)
      @addHand(new HourHand(adjustedHrLength, @context), i)

    @context.restore()


new FractalClock

