class FGoomba extends FGameObject {

  int direction = L;
  int speed = 50;
  int frame = 0;

  FGoomba(float x, float y, int w, int h) {
    super(w, h);
    setPosition(x, y);
    setName("goomba");
    setRotatable(false);
  }

  void act() {
    animate();
    collide();
    move();
  }

  void animate() {
    if (frame >= goombaAnim.length) frame = 0;
    if (frameCount % 5 == 0) {
      if (direction == R) attachImage(goombaAnim[frame]);
      else attachImage(reverseImage(goombaAnim[frame]));
      frame++;
    }
  }


  void collide() {
    if (isTouching("wall")) {
      direction *= -1;
      setPosition(getX() + direction, getY());
    }
    if (isTouching("player")) {
      if (player.getY() < getY()-gridSize) { // player collides on the top
        world.remove(this); // this = object thats calling the function
        enemies.remove(this);
        player.setVelocity(player.getVelocityX(), -300); // jump boost when kill
        score += 10;
      } else {
        //player.setPosition((player.getX() + 10)* direction, player.getY());
        player.setPosition(0, -100);
        lives--; // player collides on the side
      }
    }
  }

  void move() {
    float vy = getVelocityY();
    setVelocity(speed*direction, vy);
  }
}
