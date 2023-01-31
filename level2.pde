void loadWorld2(PImage map) {

  Fisica.init(this);
  world = new FWorld(-2000, -2000, 2000, 2000);
  world.setGravity(0, 900);

  // 2D array traversing thru grid rows
  for (int y = 0; y < map.height; y++) {
    for (int x = 0; x < map.width; x++) {
      color c = map.get(x, y); // current pixel
      color cTop = map.get(x, y-1);    // top
      color cBottom = map.get(x, y+1); // bottom
      color cLeft = map.get(x-1, y);  // right
      color cRight = map.get(x+1, y);  // right
      FBox b = new FBox(gridSize, gridSize);
      b.setPosition(x*gridSize, y*gridSize);
      b.setStatic(true);

      if (c == defaultPurple) {
        b.attachImage(defaultGround2);
        b.setName("default ground 2");
        b.setFriction(4);
        world.add(b);
      }

      if (c == solid) {
        b.attachImage(solidBlock);
        b.setName("solid block");
        b.setFriction(4);
        world.add(b);
      }

      if (c == orange) {
        FLava lavaBlock = new FLava(x*gridSize, y*gridSize);
        terrain.add(lavaBlock);
        world.add(lavaBlock);
      }

      if (c == pillar && cBottom == defaultPurple) {
        b.attachImage(bottomPillar);
        b.setPosition(x*gridSize, y*gridSize-5);
        b.setSensor(true);
        world.add(b);
      }

      if (c == pillar && cBottom == pillar) {
        b.attachImage(middlePillar);
        b.setPosition(x*gridSize, y*gridSize+5);
        b.setSensor(true);
        world.add(b);
      }

      if (c == pillar && (cTop == defaultPurple || cTop == 0)) {
        b.attachImage(topPillar);
        b.setPosition(x*gridSize, y*gridSize+5);
        b.setSensor(true);
        world.add(b);
      }

      if (c == spike2 && cBottom == defaultPurple) {
        b.attachImage(spike);
        b.setPosition(x*gridSize, y*gridSize-2);
        b.setName("spike 2");
        world.add(b);
      }

      if (c == spike2 && cRight == defaultPurple) {
        b.attachImage(RSpike);
        b.setPosition(x*gridSize, y*gridSize);
        b.setName("spike 2");
        world.add(b);
      }

      if (c == spike2 && cLeft == defaultPurple) {
        b.attachImage(LSpike);
        b.setPosition(x*gridSize+3, y*gridSize+5);
        b.setName("spike 2");
        world.add(b);
      }

      if (c == spike2 && cTop == defaultPurple) {
        b.attachImage(TSpike);
        b.setPosition(x*gridSize, y*gridSize+1);
        b.setName("spike 2");
        world.add(b);
      }

      if (c == bridge2 && (cLeft == defaultPurple)) {
        b.attachImage(RBridge);
        b.setPosition(x*gridSize, y*gridSize+1);
        b.setName("spike 2");
        world.add(b);
      }

      if (c == bridge2 && (cLeft == bridge2 || cRight == bridge2)) {
        b.setPosition(x*gridSize-5, y*gridSize);
        b.attachImage(bridge);
        b.setName("bridge 2");
        world.add(b);
      }

      if (c == bridge2 && cLeft == defaultPurple) {
        b.attachImage(LBridge);
        b.setName("bridge 2");
        world.add(b);
      }

      if (c == bridge2 && cRight == defaultPurple) {
        b.setPosition(x*gridSize-5, y*gridSize);
        b.attachImage(RBridge);
        b.setName("bridge 2");
        world.add(b);
      }

      if (c == gold) {
        Coin coin = new Coin(10*x, 10*y-15);
        terrain.add(coin);
        world.add(coin);
      }

      if (c == LBlue) {
        b.attachImage(keyPic);
        b.setPosition(x*gridSize+5, y*gridSize);
        b.setName("key 2");
        world.add(b);
      }
    }
  }
}

//=====================================================================================================================================

void loadImages2() {
  map2           = loadImage("map2 (18) (3) (3).png");
  defaultGround2 = loadImage("blocks/level2/default2.png");
  LBridge        = loadImage("blocks/level2/LBridge.png");
  bridge         = loadImage("blocks/level2/bridge.png");
  RBridge        = loadImage("blocks/level2/Rbridge.png");
  spike          = loadImage("blocks/level2/spike.png");
  RSpike         = loadImage("blocks/level2/right wall spike.png");
  LSpike         = loadImage("blocks/level2/left wall spike.png");
  TSpike         = loadImage("blocks/level2/topSpike.png");
  bottomPillar   = loadImage("blocks/level2/bottom pillar.png");
  middlePillar   = loadImage("blocks/level2/middle pillar.png");
  topPillar      = loadImage("blocks/level2/top pillar.png");
  solidBlock     = loadImage("blocks/level2/solid block.png");
  coinPic        = loadImage("blocks/level2/coin pic.png");
  keyPic        = loadImage("key.png");
  keyPic.resize(15, 15);
}
