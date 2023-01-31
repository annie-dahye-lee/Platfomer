void loadWorld1(PImage map) {

  Fisica.init(this);
  world = new FWorld(-2000, -2000, 2000, 2000);
  world.setGravity(0, 900);

  // resize block imgs
  defaultGround.resize(gridSize, gridSize);
  iceImg.resize(gridSize, gridSize);
  slimeImg.resize(gridSize, gridSize);
  spikeImg.resize(gridSize, gridSize);
  bottomBarrel.resize(gridSize, gridSize);
  topBarrel.resize(gridSize, gridSize);
  ropeImg.resize(gridSize, gridSize);
  torch.resize(gridSize, gridSize);
  bridgeImg.resize(gridSize, gridSize);

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
      b.setFriction(4);

      if (c == black) { // default ground
        b.attachImage(defaultGround);
        b.setName("default ground");
        world.add(b);
      }
      if (c == white) { // default ground
        b.attachImage(defaultGround);
        b.setName("wall");
        world.add(b);
      }
      if (c == red) { // ice
        b.attachImage(iceImg);
        b.setFriction(0);
        b.setName("ice");
        world.add(b);
      }
      if (c == green) { // slime
        b.attachImage(slimeImg);
        b.setFriction(0.3);
        b.setRestitution(0.8);
        b.setName("slime");
        world.add(b);
      }
      if (c == grey) { // spike
        b.attachImage(spikeImg);
        b.setFriction(2);
        b.setRestitution(0);
        b.setName("spike");
        // terrain.add(b);
        world.add(b);
      }

      if (c == brown && cTop == brown) { // bottom barrel
        b.attachImage(bottomBarrel);
        b.setSensor(true);
        b.setName("bottom barrel");
        world.add(b);
      }

      if (c == brown && cBottom == brown) { // top barrel
        b.attachImage(topBarrel);
        b.setSensor(true);
        b.setName("top barrel");
        world.add(b);
      }

      if (c == brown2) {
        FBox rope = new FBox(gridSize+10, gridSize+10);
        rope.attachImage(ropeImg);
        rope.setPosition(x*gridSize, y*gridSize);
        rope.setStatic(true);
        rope.setSensor(true);
        rope.setName("rope");
        world.add(rope);
      }
      if (c == yellow) {
        b.attachImage(torch);
        b.setSensor(true);
        b.setName("torch");
        world.add(b);
      }
      if (c == pink) {
        FBridge bridge = new FBridge(x*gridSize, y*gridSize);
        terrain.add(bridge);
        world.add(bridge);
      }
      if (c == orange) {
        FLava lavaBlock = new FLava(x*gridSize, y*gridSize);
        terrain.add(lavaBlock);
        world.add(lavaBlock);
      }

      if (c == blue) {
        FGoomba goomba = new FGoomba(x*gridSize+50, y*gridSize, gridSize, gridSize);
        enemies.add(goomba);
        world.add(goomba);
      }

      if (c == purple) {
        FThwomp thwomp = new FThwomp(x*gridSize, y*gridSize); // position
        enemies.add(thwomp);
        world.add(thwomp);
      }

      if (c == teal) {
        FHammerBro hammerbro = new FHammerBro(x*gridSize, y*gridSize, gridSize*2+5, gridSize*2+5);
        enemies.add(hammerbro);
        world.add(hammerbro);
      }

      if (c == LBlue) {
        b.attachImage(keyPic);
        b.setName("key");
        world.add(b);
      }
    }
  }
}

  //=====================================================================================================================================

void loadImages1() {
  map1          = loadImage("map1.png");
  iceImg        = loadImage("blocks/level1/ice.png");
  defaultGround = loadImage("blocks/level1/defaultGround.png");
  slimeImg      = loadImage("blocks/level1/slime.png");
  spikeImg      = loadImage("blocks/level1/spikes.png");
  topBarrel     = loadImage("blocks/level1/top barrel.png");
  bottomBarrel  = loadImage("blocks/level1/bottom barrel.png");
  ropeImg       = loadImage("blocks/level1/rope.png");
  torch         = loadImage("blocks/level1/torch.png");
  bridgeImg     = loadImage("blocks/level1/bridge.png");
  hammerImg     = loadImage("demon/hammer.png");
  keyPic        = loadImage("key.png");
  keyPic.resize(20, 20);

  goombaAnim = new PImage[8];
  for (int i = 0; i < 8; i++) {
    goombaAnim[i] = loadImage("goomba/frame_" + i + "_delay-0.08s.gif");
    goombaAnim[i].resize(gridSize+14, gridSize);
  }

  thwompAnim = new PImage[2]; // [0] = sleepy, [1] = angry
  for (int i = 0; i < 2; i++) {
    thwompAnim[i] = loadImage("thwomp/thwomp" + i + ".png");
    thwompAnim[i].resize(gridSize*3, gridSize*3);
  }

  hammerBroAnim = new PImage[16]; // [0] = sleepy, [1] = angry
  for (int i = 0; i < 16; i++) {
    if (i < 10) hammerBroAnim[i] = loadImage("demon/frame_0" + i + "_delay-0.1s.gif");
    else hammerBroAnim[i] = loadImage("demon/frame_" + i + "_delay-0.1s.gif");
    hammerBroAnim[i].resize(gridSize+15, gridSize+50);
  }
  lava = new PImage[76];
  for (int i = 0; i < 76; i++) {
    if (i < 10) lava[i] = loadImage("lava/frame_0" + i + "_delay-0.03s.gif");
    else lava[i] = loadImage("lava/frame_" + i + "_delay-0.03s.gif");
    lava[i].resize(gridSize, gridSize);
  }
}
