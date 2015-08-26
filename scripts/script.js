(function() {
  var btn, drow_canvas, header, icons, over, popdown, popup, runCanvas, scroll, styleEl, toggleClass;

  header = document.getElementById('top');

  btn = document.querySelector('.btn--hero');

  icons = document.querySelectorAll('.hero .nav__item');

  styleEl = document.createElement('style');

  document.head.appendChild(styleEl);

  runCanvas = true;

  over = false;

  window.onload = function() {
    btn.addEventListener('mouseenter', popup);
    btn.addEventListener('mouseleave', popdown);
    window.addEventListener('scroll', scroll);
    window.addEventListener('resize', drow_canvas);
    return drow_canvas();
  };

  drow_canvas = function() {
    var Circle, canvas, ch, circles, ctx, cw, draw, i, j, num, ref;
    canvas = document.getElementById('js-bubble');
    ctx = canvas.getContext('2d');
    cw = canvas.width = window.innerWidth;
    ch = canvas.height = header.clientHeight;
    circles = [];
    num = cw / 10;
    Circle = (function() {
      function Circle() {
        this.first = this.first === void 0 ? true : false;
        this.x = Math.random() * cw;
        this.y = this.first ? Math.random() * ch : ch;
        this.r = 0.5 + Math.random() * 3;
        this.alpha = 0.3 + Math.random() * 0.5;
        this.velocity = 0.5 + Math.random() * 2;
      }

      Circle.prototype.draw = function() {
        if (this.y < 0) {
          this.constructor();
        }
        ctx.beginPath();
        ctx.arc(this.x, this.y, this.r, 0, Math.PI * 2, false);
        ctx.fillStyle = 'rgba(255,255,255,' + this.alpha + ')';
        ctx.fill();
        return this.y -= this.velocity;
      };

      return Circle;

    })();
    for (i = j = 0, ref = num; 0 <= ref ? j < ref : j > ref; i = 0 <= ref ? ++j : --j) {
      circles.push(new Circle());
    }
    return (draw = function() {
      var c, k, len;
      if (!runCanvas) {
        return;
      }
      ctx.clearRect(0, 0, cw, ch);
      for (k = 0, len = circles.length; k < len; k++) {
        c = circles[k];
        c.draw();
      }
      return requestAnimationFrame(draw);
    })();
  };

  scroll = function() {
    scroll = window.scrollY;
    if (scroll > header.clientHeight) {
      over = true;
      runCanvas = false;
      return;
    } else {
      runCanvas = true;
      if (over) {
        drow_canvas();
      }
      over = false;
    }
    if ((50 < scroll && scroll < header.clientHeight)) {
      header.style.webkitFilter = 'blur(' + scroll / 80 + 'px)';
    } else {
      header.style.webkitFilter = 'blur(0)';
    }
    return styleEl.innerHTML = '.hero:after{transform: translate3d(' + scroll + 'px,0,0);}';
  };

  popup = function() {
    var icon, j, len, results;
    results = [];
    for (j = 0, len = icons.length; j < len; j++) {
      icon = icons[j];
      results.push(toggleClass(icon, 'popup', 'popdown'));
    }
    return results;
  };

  popdown = function() {
    var icon, j, len, results;
    results = [];
    for (j = 0, len = icons.length; j < len; j++) {
      icon = icons[j];
      results.push(toggleClass(icon, 'popdown', 'popup'));
    }
    return results;
  };

  toggleClass = function(el, add, remove) {
    el.classList.add(add);
    return el.classList.remove(remove);
  };

}).call(this);
