class FThwomp extends FGoomba {

  boolean isAngry = false;

  FThwomp(int x, int y) {
    super(x, y, gridSize*3, gridSize*3); // (x, y, w, h)
    setPosition(x+gridSize/3-6, y+gridSize/3);
    setName("thwomp");
    setRotatable(false);
    setStatic(true);
  }
  
  //=====================================================================================================================================

  void animate() {
    if (!isAngry) attachImage(thwompAnim[0]); // happy
    else attachImage(thwompAnim[1]);  // angry
  }

  //=====================================================================================================================================

  void collide() {
    if (isTouching("player") && isAngry) {
      player.setPosition(0, -100);
      lives--;
    }
  }

  //=====================================================================================================================================


  void move() {
    if (player.getX() >= this.getX() && player.getY() >= this.getY()) {
      isAngry = true;
      setStatic(false);
    }
  }
}
