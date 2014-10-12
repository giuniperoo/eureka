/* adapted from: http://userbag.co.uk/development/javascript-eyes-that-follow-the-cursor/ */
function Eye(x, y, size, append) {
  var self = this;
  var i = 0;

  this.x = x;
  this.y = y;
  this.size = size;

  //Create the Eye Dom Node useing canvas.
  this.create = function create(x, y, size, append) {
    //create dom node
    var eye = document.createElement('canvas');
    eye.width = size;
    eye.height = size;
    eye.style.position = 'absolute';
    eye.style.top = y + 'px';
    eye.style.left = x + 'px';
    document.getElementById(append).appendChild(eye);

    //get canvas
    canvas = eye.getContext('2d');

    //draw eye
    canvas.beginPath();
    radius = size / 2;
    canvas.arc(radius, radius, radius, 0, Math.PI * 2);
    canvas.closePath();

    //draw pupil
    canvas.beginPath();
    canvas.arc(radius, radius / 2, radius / 3, 0, Math.PI * 2);
    canvas.closePath();
    canvas.fillStyle = 'black';
    canvas.fill();

    return eye;
  }

  //Rotate the Dom node to a given angle.
  this.rotate = function(x){
    this.node.style.MozTransform = 'rotate(' + x + 'deg)';
    this.node.style.WebkitTransform = 'rotate(' + x + 'deg)';
    this.node.style.OTransform = 'rotate(' + x + 'deg)';
    this.node.style.msTransform = 'rotate(' + x + 'deg)';
    this.node.style.Transform = 'rotate(' + x + 'deg)';

  }

  //Update every 100 miliseconds
  setInterval(function () {
    //Math!
    angleFromEye = Math.atan2((cursorLocation.y-self.my_y), cursorLocation.x-self.my_x) * (180 / Math.PI) + 90;
    //Rotate
    self.rotate(angleFromEye);
    //Refresh own position every 25th time (in case screen is resized)
    i++; if (i > 25) { self.locateSelf(); i=0; }
  }, 100);

  this.locateSelf = function () {
    this.my_x = this.node.offsetLeft + (this.size / 2);
    this.my_y = this.node.offsetTop + (this.size / 2);

    //If it has offsetParent, add em up to get the objects full position.
    if (this.node.offsetParent) {
      temp = this.node;
      while (temp = temp.offsetParent) {
        this.my_x += temp.offsetLeft;
        this.my_y += temp.offsetTop;
      }
    }
  }

  //Call the node create function when the AlienEye Object is created.
  this.node = this.create(x,y,size,append);
  this.locateSelf();
}

//Create Object to store and provide access to current cusor position
var cursorLocation = new function() {
  this.x = 0;
  this.y = 0;

  //This function is called onmousemove to update the stored position
  this.update = function (e) {
    var w = window, b = document.body;
    this.x =  e.clientX + (w.scrollX || b.scrollLeft || b.parentNode.scrollLeft || 0);
    this.y = e.clientY + (w.scrollY || b.scrollTop || b.parentNode.scrollTop || 0);
  }
}

//Hook onmousemove up to the above update function.
document.onmousemove = function (e) { cursorLocation.update(e); };
