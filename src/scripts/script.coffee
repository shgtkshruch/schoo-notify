header = document.getElementById 'top'
btn = document.querySelector '.btn--hero'
icons = document.querySelectorAll '.hero .nav__item'

styleEl = document.createElement 'style'
document.head.appendChild styleEl

runCanvas = true
over = false

window.onload = ->
  btn.addEventListener 'mouseenter', popup
  btn.addEventListener 'mouseleave', popdown
  window.addEventListener 'scroll', scroll
  window.addEventListener 'resize', drow_canvas
  drow_canvas()

drow_canvas = ->
  canvas = document.getElementById 'js-bubble'
  ctx = canvas.getContext '2d'
  cw = canvas.width = window.innerWidth
  ch = canvas.height = header.clientHeight
  circles = []
  num = cw / 10

  class Circle
    constructor: ->
      @first = if @first is undefined then true else false
      @x = Math.random() * cw
      @y = if @first then Math.random() * ch else ch
      @r = 0.5 + Math.random() * 3
      @alpha = 0.3 + Math.random() * 0.5
      @velocity = 0.5 + Math.random() * 2

    draw: ->
      @constructor() if @y < 0

      ctx.beginPath()
      ctx.arc @x, @y, @r, 0, Math.PI * 2, false
      ctx.fillStyle = 'rgba(255,255,255,' + @alpha + ')'
      ctx.fill()
      @y -= @velocity

  circles.push new Circle() for i in [0...num]

  (draw = ->
    return if !runCanvas
    ctx.clearRect 0, 0, cw, ch
    c.draw() for c in circles

    requestAnimationFrame draw
  )()

scroll = ->
  scroll = window.scrollY
  if scroll > header.clientHeight
    over = true
    runCanvas = false
    return
  else
    runCanvas = true
    drow_canvas() if over
    over = false

  if 50 < scroll < header.clientHeight 
    header.style.webkitFilter = 'blur(' + scroll / 80 + 'px)' 
  else
    header.style.webkitFilter = 'blur(0)'

  styleEl.innerHTML = '.hero:after{transform: translate3d(' + scroll + 'px,0,0);}'

popup = -> toggleClass icon, 'popup', 'popdown' for icon in icons
popdown = -> toggleClass icon, 'popdown', 'popup' for icon in icons

toggleClass = (el, add, remove) ->
  el.classList.add add
  el.classList.remove remove
