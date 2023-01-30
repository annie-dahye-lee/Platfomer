class FLava extends FGameObject {
  
  int frame = (int) random(0, lava.length);

  FLava(float x, float y) {
    super(gridSize, gridSize);
    setPosition(x, y);
    setName("lava");
    setFriction(4);
    setStatic(true);
  }

  void act() {
    if (frame >= lava.length) frame = 0;
    if (frameCount % 2 == 0) {
      attachImage(lava[frame]);
      frame++;
    }
  }
}
