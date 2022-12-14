//Mobs are the monsters that the towers defend against.
//Mobs spawn at the start and then move across the map,
//changing direction when they hit a node. If they get
//to the end of the map, they deal damage to the player.
//Once the player has no more health, it's game over!

class Mob {
  float x, y, vx, vy;
  float speed;
  int hp, maxhp;
  color c;
  float w, h;
  int mode;
  PImage img;
  float hpw;
  int value;
  int counter;

  final static int IMG = 0;
  final static int RECTANGLE = 1;

  Mob() {
  }

  Mob(float myX, float myY, float myVX, float myVY, color myC, PImage myImg) {
    this(myX, myY, myVX, myVY);
    c = myC;
    mode = IMG;
    img = myImg;
  }

  Mob(float myX, float myY, float myVX, float myVY) {
    x = myX;
    y = myY;
    vx = myVX;
    vy = myVY;

    hp = 25;
    maxhp = hp;
    c = lightpink;
    w = 25;
    h = 25;
    mode = RECTANGLE;
    speed = 1;
  }

  void show() {
    showMobs();
    showHealthBar();
  }

  void act() {
    checkNodes();
    checkCollisions();
    move();

    if (x > 0.9*width) hp = 0;
  }

  void move() {
    x += vx*speed;
    y += vy*speed;
  }

  void checkNodes() {
    for (int i = 0; i < map1NodeList.size(); i++) {
      if (dist(currNodeList.get(i).x, currNodeList.get(i).y, x, y) <= (0.5*speed+1)) {
        vx = currNodeList.get(i).dx;
        vy = currNodeList.get(i).dy;
      }
    }

    if (dist(map1NodeList.get(map1NodeList.size()-1).x, map1NodeList.get(map1NodeList.size()-1).y, x, y) <= (speed/2+1)) {
      value = 0;
      hp = 0;
      lives--;
      texts.add(new Text(x, y-12, 15, "Lives-1" ));
    }
  }

  void showMobs() {
    mobRectangles();
    if (mode == IMG) mobImages();
  }

  void mobImages() {
    image(img, x, y, 0.95*w, 0.95*h);
  }

  void mobRectangles() {
    fill(c);
    strokeWeight(0);
    rect(x, y, w, h);
  }

  void checkCollisions() {
    for (int i = 0; i < bullets.size(); i++) {
      Bullet b = bullets.get(i);
      if (dist(b.x, b.y, x, y) < (w/2 + b.size/2)) {
        hp -= 5;
        if (!(b instanceof AoERing)) b.hp = 0;
        texts.add(new Text(x, y-13, vx, vy, 15, "hp -5", 60));
      }
    }
  }

  void showHealthBar() {
    stroke(red);
    strokeWeight(1);
    noFill();
    rect(x, y - 20, 20, 5);

    rectMode(CORNER);
    hpw = map(hp, 0, maxhp, 0, 20);
    noStroke();
    fill(red, 128);
    rect(x-10, y-22.5, hpw, 5);
    rectMode(CENTER);
  }
}
