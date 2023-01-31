class FBridge extends FGameObject {

  FBridge(float x, float y) {
    super(gridSize, gridSize);
    setPosition(x, y);
    setName("bridge");
    if (level == 1) attachImage(bridgeImg);

    setStatic(true);
  }
  
  //=====================================================================================================================================

  void act() {
    if (isTouching("player")) {
      setStatic(false);
      setSensor(true);
    }
  }
}
