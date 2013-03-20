class App.Dimensions

  @getDimensions: ->
    x: document.documentElement.clientWidth - 8
    y: document.documentElement.clientHeight - 20

  @startingBoxWidth: ->
    dimensions = @getDimensions()
    # See which dim is bigger - width or height - and return half of that. This
    # will get us the max radius of our viewport
    maxViewportRadius = Math.min(dimensions.x, dimensions.y) / 2
    # Make the clock slightly smaller than the viewport
    Math.round(maxViewportRadius * App.INITIAL_SCALE_FACTOR)
