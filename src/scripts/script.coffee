header = document.getElementById 'top'
btn = document.querySelector '.btn--hero'
icons = document.querySelectorAll '.hero .nav__item'

styleEl = document.createElement 'style'
document.head.appendChild styleEl

window.onload = ->
  btn.addEventListener 'mouseenter', popup
  btn.addEventListener 'mouseleave', popdown
  window.addEventListener 'scroll', scroll

scroll = ->
  scroll = window.scrollY
  return if scroll > header.clientHeight

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
