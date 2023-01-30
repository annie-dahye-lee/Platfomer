class Coin extends FGameObject {

  Coin(float x, float y) {
    super(gridSize, gridSize);
    setPosition(x, y);
    setRotatable(false);
    setName("coin");
    attachImage(coinPic);
    setStatic(false);
  }

  void act() {
    if (isTouching("player")) {
      world.remove(this);
      score += 5;
    }
  }
}
