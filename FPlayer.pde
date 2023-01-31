class FPlayer extends FGameObject {

  int frame;
  int direction;

  FPlayer() {

    super(gridSize, gridSize+20); // FGameObject's constructor (w, h)
    setPosition(300, 0);
    setRotatable(false);
    setDensity(4);
    setFillColor(blue);
    setName("player");

    lives = 6;
    frame = 0;
    direction = R;
  }

  //=====================================================================================================================================


  void act() {
    input();
    collisions();
    animate();
  }

  //=====================================================================================================================================


  void input() {
    float vx = getVelocityX();
    float vy = getVelocityY();

    if (vy == 0) action = idle;

    if (wkey && (isTouching("default ground") || isTouching("default ground 2") || (isTouching("solid block") || (isTouching("ice")) || (isTouching("bridge"))  || (isTouching("bridge 2")) || isTouching("slime") || isTouching("lava")))) {
      if (level == 1) setVelocity(vx, -300);
      else setVelocity(vx, -250);
    }

    if (abs(vy) > 0.1) {
      action = jump;
    }

    if (akey) {
      setVelocity(-150, vy);
      action = run;
      direction = L;
    }

    if (skey) {
      setVelocity(vx, 200);
      action = dive;
    }
    if (dkey) {
      setVelocity(150, vy);
      action = run;
      direction = R;
    }
  }

  //=====================================================================================================================================


  void collisions() {
    if (isTouching("spike")) {
      player.setPosition(0, -100);
      lives--;
    }

    if (isTouching("spike 2")) {
      setPosition(0, -30);
      lives--;
    }

    if (isTouching("hammer")) {
      world.remove(hammer);
      player.setPosition(0, -100);
      lives--;
    }

    if (isTouching("lava")) {
      player.setPosition(0, -100);
      lives--;
    }

    if (isTouching("key")) keyObtained = true;
    if (isTouching("key 2")) key2Obtained = true;

    //if (isTouching("coin")) {
    //  world.remove(coin);
    //  score += 5;
    //  println(score);
    //}


    //if (lives <= 0) {
    //  setPosition(60, -40);
    //  lives = 5;
    //}
  }

  //=====================================================================================================================================


  void animate() {
    if (frame >= action.length) frame = 0;
    if (frameCount % 5 == 0) {
      if (direction == R) attachImage(action[frame]);
      else attachImage(reverseImage(action[frame]));
      frame++;
    }

    hp();
  }

  //=====================================================================================================================================


  void hp() {
    if (lives == 6) {
      image(fullHeart, 20, 70, 35, 35);
      image(fullHeart, 65, 70, 35, 35);
      image(fullHeart, 112, 70, 35, 35);
    }

    if (lives == 5) {
      image(fullHeart, 20, 70, 30, 30);
      image(fullHeart, 65, 70, 30, 30);
      image(halfHeart, 112, 70, 30, 30);
    }

    if (lives == 4) {
      image(fullHeart, 20, 70, 30, 30);
      image(fullHeart, 65, 70, 30, 30);
    }

    if (lives == 3) {
      image(fullHeart, 20, 70, 30, 30);
      image(halfHeart, 65, 70, 30, 30);
    }

    if (lives == 2) {
      image(fullHeart, 20, 70, 30, 30);
    }

    if (lives == 1) {
      image(halfHeart, 20, 70, 30, 30);
    }
  }
}
