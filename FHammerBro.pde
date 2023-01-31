class FHammerBro extends FGoomba {

  int timer;

  FHammerBro(float x, float y, int w, int h) {
    super(x, y, w, h);
    setPosition(x, y);
    setName("hammer bro");
    setRotatable(false);

    timer = 0;
  }

  //=====================================================================================================================================


  void act() {
    animate();
    collide();
    move();
  }

  //=====================================================================================================================================

  void animate() {
    if (frame >= hammerBroAnim.length) frame = 0;
    if (frameCount % 5 == 0) {
      if (direction == R) attachImage(hammerBroAnim[frame]);
      else attachImage(reverseImage(hammerBroAnim[frame]));
      frame++;
    }
    timer++;
    if (timer > 100) {
      throwHammer();
      timer = 0;
    }
  }

  //=====================================================================================================================================

  void throwHammer() {
    hammerImg.resize(23, 23);

    hammer.attachImage(hammerImg);
    hammer.setPosition(this.getX(), this.getY()-50);
    hammer.setVelocity((int) random(-2, 2), -500);
    //hammer.setAngularVelocity(r1);
    hammer.setSensor(true); // prevent from piling up

    hammer.setName("hammer");
    world.add(hammer);
  }
}
