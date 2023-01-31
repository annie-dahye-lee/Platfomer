// level2: diff tileset, coins, and powerups

import fisica.*;
FWorld world;

// pallette
color green   = #00ff1e;  // slime
color brown   = #964b00;  // barrel
color brown2  = #6d2c2c;  // rope
color grey    = #4d4d4d;  // spike
color red     = #ff0000;  // ice for some reason
color orange  = #ff6500;  // lava
color blue    = #1a00ff;  // goomba
color purple  = #8000ff;  // thwomp
color teal    = #00ffbb;  // hammerbro
color LBlue   = #00b7d9;
color salmon  = #fed9b7;
color white   = #ffffff;
color black   = #000000;
color iceBlue = #5b69d4;
color yellow  = #fbff00;
color pink    = #ff89b3; // bridge

//lvl2
color defaultPurple = #8f00ac;
color spike2 = #0bc29e;
color bridge2 = #b96217;
color pillar = #c783d5;
color solid = #39006e;
color gold = #39006e;

// keyboard
boolean wkey, akey, skey, dkey, spacekey, upkey, downkey, leftkey, rightkey;
boolean keyObtained, key2Obtained;
boolean mouseReleased, wasPressed;

PFont tandy;

// images
PImage map1, map2, fullHeart, halfHeart, win;

// lvl1 blocks
PImage defaultGround, iceImg, slimeImg, spikeImg, topBarrel, bottomBarrel, ropeImg, torch, bridgeImg, hammerImg, keyPic;
PImage[] lava;
PImage[] goombaAnim;
PImage[] thwompAnim;
PImage[] hammerBroAnim;

// lvl2 blocks
PImage defaultGround2, LBridge, bridge, RBridge, LSpike, spike, TSpike, RSpike, bottomPillar, middlePillar, topPillar, solidBlock, coinPic;

// player animations
PImage[] idle;
PImage[] run;
PImage[] jump;
PImage[] dive;
PImage[] action;

Button retry;

// values
int frame = 0;
int lives;
int level = 1;
int score = 30;
int gridSize; // lvl1 = 19
float zoom; // lvl1 = 2;

// FBodies and object lists
FPlayer player;
FBox hammer;

ArrayList<FGameObject> terrain;
ArrayList<FGameObject> enemies;

//=====================================================================================================================================

void setup() {
  size(600, 600);
  Fisica.init(this);
  world = new FWorld();
  world.setGravity(0, 980);
  world.setEdges();
  
  // button & fonts
  retry = new Button("TRY AGAIN", 340, 500, 300, 120, pink, white);
  tandy = createFont("tandy.ttf", 32);
  
  // FGameObject ArrayLists
  terrain = new ArrayList<FGameObject>();
  enemies = new ArrayList<FGameObject>();
  hammer = new FBox(23, 23);

  level = 1;
  loadWorld();

}

void animation(PImage[] a, String folder, int numFrames) {
  a = new PImage[numFrames];
  for (int i = 0; i < 8; i++) {
    a[i] = loadImage("frame_" + i + "_delay-0.07s.gif");
    if (level == 1)a[i].resize(gridSize+23, gridSize+30);
    else a[i].resize(gridSize+8, gridSize+15);
  }
}

void loadWorld() {
  if (level == 1) {
    gridSize = 19;
    zoom = 2;
    loadImages1();
    loadWorld1(map1);
    loadPlayer();
  }

  if (level == 2) {
    gridSize = 10;
    zoom = 3;
    loadImages2();
    loadWorld2(map2);
    loadPlayer();
  }
}

//=====================================================================================================================================

void loadPlayer() {
  idle = new PImage[6];
  for (int i = 0; i < 6; i++) {
    idle[i] = loadImage("idle/frame_" + i + "_delay-0.1s.gif");
    if (level == 1) idle[i].resize(gridSize+12, gridSize+30);
    else idle[i].resize(gridSize+2, gridSize+13);
  }

  run = new PImage[8];
  for (int i = 0; i < 8; i++) {
    run[i] = loadImage("run/frame_" + i + "_delay-0.07s.gif");
    if (level == 1)run[i].resize(gridSize+23, gridSize+30);
    else run[i].resize(gridSize+8, gridSize+15);
  }

  jump = new PImage[2];
  for (int i = 0; i < 2; i++) {
    jump[i] = loadImage("jump/frame_" + i + "_delay-0.1s.gif");
    if (level == 1) jump[i].resize(gridSize+12, gridSize+30);
    else jump[i].resize(gridSize+5, gridSize+15);
  }

  dive = new PImage[2];
  for (int i = 0; i < 2; i++) {
    dive[i] = loadImage("dive/frame_" + i + "_delay-0.1s.gif");
    if (level == 1) dive[i].resize(gridSize+10, gridSize+35);
    else dive[i].resize(gridSize+5, gridSize+15);
  }

  action = idle;

  // create player
  player = new FPlayer();
  player.setPosition(0, -100);
  world.add(player);

  fullHeart = loadImage("full heart.png");
  halfHeart = loadImage("half heart.png");
  win       = loadImage("win.jpeg");
}

//=====================================================================================================================================

void drawWorld() {
  pushMatrix();
  translate(-player.getX()*zoom+width/2, -player.getY()*zoom+height/2);
  scale(zoom);
  world.step(); // does physics
  world.draw(); // draws world
  popMatrix();
}

//=====================================================================================================================================

void actWorld() {
  player.act();

  // loop thru terrain gameobjects at m2ake em act (bridge statics & lava animation)
  for (int i = 0; i < terrain.size(); i++) {
    FGameObject t = terrain.get(i);
    t.act();
  }

  for (int i = 0; i < enemies.size(); i++) {
    FGameObject e = enemies.get(i);
    e.act();
  }

  levels();
}

//=====================================================================================================================================

void draw() {
  background(black);
  drawWorld();
  actWorld();
  fill(white);
  textSize(50);
  textFont(tandy);
  if (!key2Obtained) text("SCORE: " + score, 20, 50);
  else text("SCORE: " + score, 250, 150);
}

//=====================================================================================================================================

void levels() {
  if (level == 1 && score == 30 && keyObtained) {
    level = 2;
    gridSize = 10;
    zoom = 3;
    loadImages2();
    loadWorld2(map2);
    loadPlayer();
  }

  if (level == 2 && score >= 55 && key2Obtained) {
    gridSize = 19;
    zoom = 2;
    textSize(50);
    image(win, 0, 0, width, height);
    retry.show();
  }
}

//=====================================================================================================================================
