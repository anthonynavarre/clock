class AnimatedNumber

  constructor: (context) ->
    @context = context
    @lineHeight = 35
    @currentYOffsets = [0, 0]
    topThing = document.createElement('img')
    topThing.src = '/assets/testtop.png'
    botThing = document.createElement('img')
    botThing.src = '/assets/testbottom.png'
    topThing.style.visibility = botThing.style.visibility = 'hidden'

    @topImg = topThing
    @bottomImage = botThing

    document.body.appendChild(topThing)
    document.body.appendChild(botThing)

  drawNumber: (number, zeroPad=true) ->
    displayStrategy = if zeroPad then toDoubleDigit else twelveHour
    @context.save()
    @context.translate(10, 40)
    @context.font = "24pt Helvetica-Bold"
    currDigits = displayStrategy(number).split(new RegExp())

    @digits      ?= currDigits
    @digitWidths  = (@context.measureText(digit).width for digit in @digits)
    @digitWidths.unshift(0)
    @digitWidths.pop()

    if !arrayEql(@digits, currDigits) && ! @newDigits
      @newDigits = currDigits
      @newDigitWidths = (@context.measureText(digit).width for digit in currDigits)
      @newDigitWidths.unshift(0)
      @newDigitWidths.pop()

    for digit, index in @digits
      if @currentYOffsets[index] < @lineHeight
        if @newDigits && @digits[index] != @newDigits[index]
          @currentYOffsets[index] += 5 # has to be some even multiple of line height
          @drawDigit(@newDigits[index], index, @currentYOffsets[index] - @lineHeight)
      else if @currentYOffsets[index] == @lineHeight
        @currentYOffsets[index] = 0
        @digits[index]          = @newDigits[index]
        @digitWidths[index]     = @newDigitWidths[index]
        @newDigits[index]       = @newDigitWidths[index] = null
        digit = @digits[index]

      @drawDigit(digit, index)

    @drawMasks()
    #@drawImages()

    @context.restore()
    @newDigits = @newDigitWidths = null unless _.all(@newDigits, (digit) -> digit? )

  drawDigit: (number, atIndex, yOffset=null) ->
    yOffset ?= @currentYOffsets[atIndex]
    @context.fillText(number, @digitWidths[atIndex], yOffset)

  drawMasks: ->
    width = sum((@context.measureText(digit).width for digit in @digits))
    @context.clearRect(0, -@lineHeight * 2 + 6, width, @lineHeight)
    @context.clearRect(0, 6, width, @lineHeight)

  drawImages: ->
    @context.drawImage(@topImg, -25, -@lineHeight + 6)
    @context.drawImage(@bottomImage, -25, 2)

  sum = (arr) ->
    memo = 0
    memo += current for current in arr
    memo

  toDoubleDigit = (number, pad='0') ->
    numstr = number.toString()
    return "#{pad}#{numstr}" if numstr.length == 1
    numstr

  twelveHour = (number) ->
    num = if number > 12 then number - 12 else number
    num = 12 if num == 0
    toDoubleDigit(num, " ")

  arrayEql = (arr1, arr2) ->
    max = Math.max(arr1.length, arr2.length)
    for i in [0...max]
      return false if arr1[i] != arr2[i]
    true

window.AnimatedNumber = AnimatedNumber
