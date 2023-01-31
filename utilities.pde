PImage reverseImage(PImage image) {
  PImage reverse;
  reverse = createImage(image.width, image.height, ARGB );
  for (int i=0; i < image.width; i++ ) {
    for (int j=0; j < image.height; j++) {
      int xPixel, yPixel;
      xPixel = image.width - 1 - i;
      yPixel = j;
      reverse.pixels[yPixel*image.width+xPixel]=image.pixels[j*image.width+i] ;
    }
  }
  return reverse;
}

//=====================================================================================================================================

void click() {
  mouseReleased = false;
  // mousePressed is built-in variable
  if (mousePressed) wasPressed = true;
  if (wasPressed && !mousePressed) { // mouse WAS pressed & not currently pressed = mouse is released
    mouseReleased = true;
    wasPressed = false;
  }

  if (retry.clicked) {
    level = 1;
    gridSize = 10;
    zoom = 3;
    loadImages1();
    loadWorld1(map1);
    loadPlayer();
  }
}
