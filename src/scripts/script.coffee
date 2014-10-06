header = null
btn = document.querySelector '.btn--hero'
icons = document.querySelectorAll '.hero .nav__item'

window.onload = ->
  btn.addEventListener 'mouseenter', popup
  btn.addEventListener 'mouseleave', popdown
  window.addEventListener 'resize', drow_canvas
  window.addEventListener 'scroll', scroll
  drow_canvas()

drow_canvas = ->
  canvas = document.getElementById 'js-bubble'
  header = document.getElementById 'top'
  ctx = canvas.getContext '2d'
  cw = canvas.width = window.innerWidth
  ch = canvas.height = header.clientHeight
  circles = []
  num = cw / 3

  header.style.pointerEvents = 'none'

  class Circle
    constructor: ->
      @x = Math.random() * cw
      @y = ch + Math.random() * 100
      @r = 1 + Math.random() * 30
      @alpha = 0.1 + Math.random() * 0.3
      @velocity = 3 + Math.random() * 5

    draw: ->
      @alpha -= 0.0003

      # @constructor() if @alpha < 0 or @y < 0

      ctx.beginPath()
      ctx.arc @x, @y, @r, 0, Math.PI * 2, false
      ctx.fillStyle = 'rgba(255,255,255,' + @alpha + ')'
      ctx.fill()
      @y -= @velocity

  for i in [0...num]
    circles.push new Circle()
  
  (draw = ->
    return if timer is 'end'
    ctx.clearRect 0, 0, cw, ch

    circles.forEach (c) ->
      c.draw()

    requestAnimationFrame draw
  )()

  timer = ''
  setTimeout ->
    timer = 'end'
  , 5000

  setTimeout ->
    header.style.pointerEvents = 'auto'
  , 3000

scroll = ->
  scroll = window.scrollY
  if 0 < scroll < header.clientHeight 
    header.style.webkitFilter = 'blur(' + scroll / 100 + 'px)' 
  else
    header.style.webkitFilter = 'blur(0)'

popup = (e) ->
  for icon in icons
    icon.classList.add 'popup' 
    icon.classList.remove 'popdown' 

popdown = (e) ->
  for icon in icons
    icon.classList.remove 'popup' 
    icon.classList.add 'popdown' 
