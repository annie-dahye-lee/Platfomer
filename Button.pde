class Button {
  // instance variables
  int x, y, w, h, r, textSize; // x, y is center
  boolean clicked; // is button being clicked?
  boolean hasLabel;
  color highlight, normal;
  String text;
  PImage img;

  // text label constructor
  Button(String t, int x, int y, int w, int h,color norm, color high) {
    this.text = t;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.r = 10; // rounded edges
    this.textSize = 50;
    // colors
    this.hasLabel = true;
    this.normal = norm;
    this.highlight = high;
    this.clicked = false;
  }

  // image constructor
  Button(PImage img, int x, int y, int w, int h, int r, color norm, color high) {
    this.hasLabel = false;
    this.img = img;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.r = r; // rounded edges
    // colors
    this.normal = norm;
    this.highlight = high;
    this.clicked = false;
  }

  boolean touchingMouse() {
    if (mouseX > x-w/2 && mouseX < x+w/2 && mouseY > y-h/2 && mouseY < y+h/2) return true;
    return false;
  }
  // behaviour functions
  void show() {
    drawRect();
    if (hasLabel) drawLabel(this.textSize);
    else drawImg();
    checkForClick();
  }

  void drawRect() {
    // draw rectangle
    rectMode(CENTER);
    stroke(0);
    strokeWeight(2);
    tactileButton(this.x, this.y, this.w, this.h);
    rect(x, y, w, h, r);
  }

  void drawLabel(int textSize) { // w/4
    // draw text label
    textAlign(CENTER, CENTER);
    textSize(textSize); // quarter of the button width
    tactileText(this.x, this.y, this.w, this.h);
    text(text, this.x, this.y); // x and y centered
  }

  void drawImg() {
    image(this.img, w+80, h-100, 150, 150);
  }

  void tactileButton(int x, int y, int w, int h) {
    // button x and y is center, not top left corner
    if (touchingMouse()) fill(this.highlight);
    else fill(this.normal);
  }
  void tactileText(int x, int y, int w, int h) {
    // button x and y is center, not top left corner
    if (touchingMouse()) fill(this.normal);
    else fill(this.highlight);
  }

  void checkForClick() {
    if (mouseReleased && touchingMouse()) {
      clicked = true;
    } else clicked = false;
  }
}
