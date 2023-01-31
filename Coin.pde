class Coin extends FGameObject {

  Coin(float x, float y) {
    super(19, 19);
    setPosition(x+10, y-10);
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
