header = document.querySelector '#top'
btnHero = document.querySelector '.btn--hero'
btnRotate = document.querySelectorAll '.btn--rotate'
btnImgs = document.querySelectorAll '.item__img'
icons = document.querySelectorAll '.hero .nav__item'

styleEl = document.createElement 'style'
document.head.appendChild styleEl

window.onload = ->
  hover btnHero, popup, popdown
  hover btn, rotate, rotate for btn in btnRotate
  window.addEventListener 'scroll', scroll

scroll = ->
  scroll = window.scrollY
  return if scroll > header.clientHeight

  if 50 < scroll < header.clientHeight 
    header.style.webkitFilter = 'blur(' + scroll / 50 + 'px)' 
  else
    header.style.webkitFilter = 'blur(0)'

  styleEl.innerHTML = '.hero:after{transform: translate3d(' + scroll + 'px,0,0);}'

hover = (el, enter, leave) ->
  el.addEventListener 'mouseenter', enter
  el.addEventListener 'mouseleave', leave

popup = -> toggleClass icon, 'popup', 'popdown' for icon in icons
popdown = -> toggleClass icon, 'popdown', 'popup' for icon in icons

toggleClass = (el, add, remove) ->
  el.classList.add add
  el.classList.remove remove

rotate = (e) -> 
  num = e.target.dataset.num
  btn = btnImgs[num - 1]
  btn.classList.toggle 'rotate'
