#= require 'clock/dimensions'
#= require 'clock/hand'
#= require 'clock/hands'
#= require 'clock/color'
#= require 'clock/clock'
#= require 'clock/sub_clock'
#= require 'clock/number_clock'

class App.DrawManager

  colors: (App.Color.random() for __ in [1..3])

  constructor: (drawOnce=false) ->
    @canvas  = document.getElementById('clock')
    @context = @canvas.getContext('2d')

    @bindEvents()
    @redraw()
    @setup()

    if drawOnce
      @drawCanvas()
    else
      @start()


  setup: ->
    @context.lineCap = "round"
    @context.lineWidth = App.STARTING_HAND_WIDTH


  bindEvents: ->
    window.onresize = @redraw.bind(@)


  start: ->
    @interval = setInterval @drawCanvas.bind(@), 1000 / App.FRAMERATE


  redraw: ->
    clearInterval @interval
    dimensions = App.Dimensions.getDimensions()
    @canvas.setAttribute('width', dimensions.x)
    @canvas.setAttribute('height', dimensions.y)
    @context.translate(dimensions.x / 2, dimensions.y / 2)
    @setup()
    @start()


  drawCanvas: ->
    @clear()
    new App.Clock(@context, App.Dimensions.startingBoxWidth(), @colors).draw()
    new App.NumberClock(@context, @colors).draw()


  clear: ->
    @context.clearRect -(@canvas.width / 2), -(@canvas.height / 2), @canvas.width, @canvas.height


new App.DrawManager
