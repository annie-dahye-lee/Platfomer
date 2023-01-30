// level2: diff tileset, coins, and powerups //<>//

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

PFont tandy;

// images
PImage map1, map2, fullHeart, halfHeart;

// lvl1 blocks
PImage defaultGround, iceImg, slimeImg, spikeImg, topBarrel, bottomBarrel, ropeImg, torch, bridgeImg, hammerImg;
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

// values
int frame = 0;
int lives;
int level = 1;
int score;
int gridSize; // lvl1 = 19
float zoom; // lvl1 = 2;

// FBodies and object lists
FPlayer player;
FBox hammer, coin;

ArrayList<FGameObject> terrain;
ArrayList<FGameObject> enemies;
ArrayList<FBox> coins;

void setup() {
  size(600, 600);
  Fisica.init(this);
  tandy = createFont("tandy.ttf", 32);

  terrain = new ArrayList<FGameObject>();
  enemies = new ArrayList<FGameObject>();

  hammer = new FBox(23, 23);
  coins = new ArrayList<FBox>();
  coin = new FBox(23, 23);

  level = 1;


  if (level == 1) {
    gridSize = 19;
    zoom = 2;
    loadImages1();
    loadWorld();
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

void loadImages() {
  // make load gif function later
  //  animation(run, "run", 8);
  //for (int i = 0; i < action.length; i++) {
  //  action[i].resize(gridSize+20, gridSize+20);
  //}
}

void animation(PImage[] a, String folder, int numFrames) {
  a = new PImage[numFrames];
}

void loadWorld() {
  //Fisica.init(this);
  //world = new FWorld(-2000, -2000, 2000, 2000);
  //world.setGravity(0, 900);
}

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


  player = new FPlayer();
  player.setPosition(0, -100);
  world.add(player);

  //lava = new PImage[76];
  //for (int i = 0; i < 76; i++) {
  //  if (i < 10) lava[i] = loadImage("lava/frame_0" + i + "_delay-0.03s.gif");
  //  else lava[i] = loadImage("lava/frame_" + i + "_delay-0.03s.gif");
  //  lava[i].resize(gridSize, gridSize);
  //}

  fullHeart = loadImage("full heart.png");
  halfHeart = loadImage("half heart.png");
  coinPic   = loadImage("blocks/level2/coin.png");
}

void draw() {
  background(black);
  drawWorld();
  actWorld();
  fill(white);
  textSize(50);
  textFont(tandy);
  text("SCORE: " + score, 20, 50);
}

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

  if (player.getX() > 550) {
    level = 2;
    gridSize = 10;
    zoom = 3;
    loadImages2();
    loadWorld2(map2);
    loadPlayer();
  }
}

void drawWorld() {
  pushMatrix();
  translate(-player.getX()*zoom+width/2, -player.getY()*zoom+height/2);
  scale(zoom);
  world.step(); // does physics
  world.draw(); // draws world
  popMatrix();
}
