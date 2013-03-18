#= require 'clock/hand'
#= require 'clock/hands'
#= require 'clock/color'

class App.Clock

  constructor: ->
    @canvas = document.getElementById('clock')
    @context = @canvas.getContext('2d')

    @bindResizeEvents()

    @drawCanvas()
    @setDefaults()

    @beginClock()


  setDefaults: ->
    @iterations = 4
    @context.strokeStyle = App.Color.random()


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

    @addHand new App.SecondHand(App.SEC_HAND_LENGTH, @context)
    @addHand new App.MinuteHand(App.MIN_HAND_LENGTH, @context)
    @addHand new App.HourHand(App.HR_HAND_LENGTH, @context)


  addHand: (hand) ->
    hand.draw()


new App.Clock

