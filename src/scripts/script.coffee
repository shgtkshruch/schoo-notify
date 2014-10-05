header = null

window.onload = ->
  drow_canvas()
  window.addEventListener 'resize', drow_canvas
  window.addEventListener 'scroll', scroll

drow_canvas = ->
  canvas = document.getElementById 'js-bubble'
  header = document.getElementById 'top'
  ctx = canvas.getContext '2d'
  cw = canvas.width = window.innerWidth
  ch = canvas.height = header.clientHeight
  circles = []
  num = cw / 10

  class Circle
    constructor: ->
      @x = Math.random() * cw
      @y = ch + Math.random() * 100
      @r = 1 + Math.random() * 7
      @alpha = 0.1 + Math.random() * 0.3
      @velocity = 0.3 + Math.random()

    draw: ->
      @alpha -= 0.0003

      @constructor() if @alpha < 0 or @y < 0

      ctx.beginPath()
      ctx.arc @x, @y, @r, 0, Math.PI * 2, false
      ctx.fillStyle = 'rgba(255,255,255,' + @alpha + ')'
      ctx.fill()
      @y -= @velocity

  for i in [0...num]
    circles.push new Circle()

  (draw = ->
    ctx.clearRect 0, 0, cw, ch

    circles.forEach (c) ->
      c.draw()

    requestAnimationFrame draw
  )()

scroll = ->
  scroll = window.scrollY
  if 0 < scroll < header.clientHeight 
    header.style.webkitFilter = 'blur(' + scroll / 100 + 'px)' 
  else
    header.style.webkitFilter = 'blur(0)'


