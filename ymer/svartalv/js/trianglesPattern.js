
var config = {
  num_rows: 8,
  num_cols: 10,
  vx: 57,
  vy: 3,
}

var util = {


  fill: function (rgb, amt) {
    ctx.beginPath();
    ctx.rect(- canvas.width / 2, - canvas.height / 2, canvas.width, canvas.height)
    ctx.fillStyle = `rgba(${rgb[0]}, ${rgb[1]}, ${rgb[2]}, ${amt})`
    ctx.fill()
  },

  drawCircle: function (x, y, r, color) {
    ctx.beginPath()
    ctx.arc(x, y, r, 0, 2 * Math.PI)
    ctx.fillStyle = color || 'white'
    ctx.fill()
    ctx.closePath()
  },

  path: function (points, close) {

    var pts = [].concat.apply([], points);

    ctx.moveTo(pts[0], pts[1])
    for (let i = 2; i < pts.length; i+=2) {

      ctx.lineTo(pts[i], pts[i+1]);
    }

    if (close === true) {

      ctx.lineTo(pts[0], pts[1]);
    }
  },
  bezier(points, offset_x, offset_y, scale_x, scale_y) {

    var pts = [].concat.apply([],points);
    ctx.moveTo(
      pts[0] * scale_x + offset_x,
      pts[1] * scale_y + offset_y
    );
    ctx.bezierCurveTo(
      pts[2] * scale_x + offset_x,
      pts[3] * scale_y + offset_y,
      pts[4] * scale_x + offset_x,
      pts[5] * scale_y + offset_y,
      pts[6] * scale_x + offset_x,
      pts[7] * scale_y + offset_y
    );
  },
  quad(points, offset_x, offset_y, scale_x, scale_y) {

    var pts = [].concat.apply([],points);
    ctx.moveTo(
      pts[0] * scale_x + offset_x,
      pts[1] * scale_y + offset_y
    );
    ctx.quadraticCurveTo(
      pts[2] * scale_x + offset_x,
      pts[3] * scale_y + offset_y,
      pts[4] * scale_x + offset_x,
      pts[5] * scale_y + offset_y
    );
  },

  rect (x, y, w, h) {

    ctx.moveTo(x, y)
    ctx.lineTo(x + w, y);
    ctx.lineTo(x + w, y + h);
    ctx.lineTo(x, y + h);
    ctx.lineTo(x, y);
  },

  hsla(h, s, l, a) {
    return 'hsla(' + h + ',' + s * 100 + '%,' + l * 100 + '%,' + a + ')';
  },
  rgba(r, g, b, a) {
    return 'rgba(' + r + ',' + g + ',' + b + ',' + a + ')';
  },

  randomSeed(seed) {
    this._seed = seed % 2147483647;
    if (this._seed <= 0) this._seed += 2147483646;
  },

  randomNext() {
    if (this._seed === undefined) {
      this.randomSeed(1);
    }
    return this._seed = this._seed * 16807 % 2147483647;
  },

  random(min, max) {
    if (min === undefined) min = 0;
    if (max === undefined) max = 1;
    return (this.randomNext() - 1) / 2147483646 * (max - min) + min;
  }
};


var canvas = document.createElement("canvas")


var ctx = canvas.getContext("2d")


document.getElementById("trianglesPattern").appendChild(canvas)

var bg = [255, 255, 255]

var wh = window.innerHeight;

function setup() {

  canvas.width = window.innerWidth;
  canvas.height = window.innerHeight;

  wh = window.innerWidth < window.innerHeight ? window.innerWidth : window.innerHeight;
  wh -= 40;

  ctx.translate(canvas.width / 2, canvas.height / 2);

  util.fill(bg, 1);
}


setup();


window.addEventListener("resize", setup)
var frameAnimId;


var elements = [];
for (var col = 0; col < config.num_cols; col++) {
  for (var row = 0; row < config.num_rows; row++) {
    elements.push(new Thingy( row, col ))
    if(row > 0) {
      elements.push(new Thingy( row, col + 0.5 ))
    }
  }
}

var l = 0;
var lMax = 140;

function draw() {
  l = (l + 1) % lMax;


  frameAnimId = window.requestAnimationFrame(function () { draw() })
  util.fill(bg, 1);

  for (var i = 0; i < elements.length; i++) {
    elements[i].draw()
  }

}

window.requestAnimationFrame(draw);

function Thingy(row, col) {
  this.row = row;
  this.col = col;
  this.rowNorm = row / config.num_rows;
  this.colNorm = col / config.num_cols;
  this.x = this.colNorm * wh - wh / 2;
  this.y = this.rowNorm * wh - wh / 2;
  this.w = wh / config.num_cols;
  this.h = wh / config.num_rows;
  this.s = [];
  this.maxS = 20;

  if (this.col % 2 === 0.5) {
    this.path = [
      [this.x - this.w * 0.5, this.y - this.h / 2],
      [this.x + this.w * 0.5, this.y],
      [this.x - this.w * 0.5, this.y + this.h / 2]
    ]
    this.c = [0, 0]
    this.path.forEach(p => {this.c[0] += p[0] / this.path.length});
    this.path.forEach(p => {this.c[1] += p[1] / this.path.length});
  }
  else if (this.col % 2 === 1.5) {
    this.path = [
      [this.x + this.w * 0.5, this.y - this.h / 2],
      [this.x - this.w * 0.5, this.y ],
      [this.x + this.w * 0.5, this.y + this.h / 2]
    ]
    this.c = [0, 0]
    this.path.forEach(p => {this.c[0] += p[0] / this.path.length});
    this.path.forEach(p => {this.c[1] += p[1] / this.path.length});
  }
  else if (this.col % 2 === 1) {
    this.path = [
      [this.x, this.y],
      [this.x + this.w , this.y + this.h/2],
      [this.x, this.y + this.h]
    ]
    this.c = [0, 0]
    this.path.forEach(p => {this.c[0] += p[0] / this.path.length});
    this.path.forEach(p => {this.c[1] += p[1] / this.path.length});
  }
  else {
    this.path = [
      [this.x + this.w, this.y],
      [this.x , this.y + this.h/2],
      [this.x + this.w, this.y + this.h]
    ]
    this.c = [0, 0]
    this.path.forEach(p => {this.c[0] += p[0] / this.path.length});
    this.path.forEach(p => {this.c[1] += p[1] / this.path.length});
  }

  this.draw = function () {

    var n = (Math.sin((this.rowNorm * 0.3 + l / lMax) * Math.PI * 2) + 1) * 0.48;

    var pts = this.path.map(pt => {
      return [
        pt[0] * n + (this.c[0]) * (1 - n),
        pt[1] * n + (this.c[1]) * (1 - n),
      ]
    })

    ctx.beginPath();
    ctx.fillStyle = util.rgba(238, 232, 213, 1);
    util.path(pts, true);
    ctx.fill();
  }
}
