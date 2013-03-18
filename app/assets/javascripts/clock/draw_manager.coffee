#= require 'clock/hand'
#= require 'clock/hands'
#= require 'clock/color'
#= require 'clock/clock'

class App.DrawManager

  _getDimensions = ->
    x: document.documentElement.clientWidth - 8
    y: document.documentElement.clientHeight - 20

  _getBoxWidth = ->
    dimensions = _getDimensions()
    # See which dim is bigger - width or height - and return half of that. This
    # will get us the max radius of our viewport
    maxViewportRadius = Math.min(dimensions.x, dimensions.y) / 2
    # Make the clock slightly smaller than the viewport
    Math.round(maxViewportRadius * 0.66)

  constructor: ->
    @canvas = document.getElementById('clock')
    @context = @canvas.getContext('2d')

    @bindEvents()
    @redraw()
    @setup()

    setInterval @drawCanvas.bind(@), 25


  setup: ->
    @context.strokeStyle = App.Color.random()


  bindEvents: ->
    window.onresize = @redraw.bind(@)


  redraw: ->
    dimensions = _getDimensions()
    @canvas.setAttribute('width', dimensions.x)
    @canvas.setAttribute('height', dimensions.y)
    @context.translate(dimensions.x / 2, dimensions.y / 2)


  drawCanvas: ->
    @clear()
    new App.Clock(@context, _getBoxWidth()).draw()


  clear: ->
    @context.clearRect -(@canvas.width / 2), -(@canvas.height / 2), @canvas.width, @canvas.height


new App.DrawManager()
