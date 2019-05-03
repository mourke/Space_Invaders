import processing.sound.*;

class Player {

  private Rect frame;
  private PImage shipImage;
  private int lives;
  private ArrayList<Bullet> bullets;
  private SoundFile shootSound;


  Player(Rect frame, PImage shipImage, int lives, SoundFile shootSound) {
    this.frame = frame;
    this.shipImage = shipImage;
    this.lives = lives;
    bullets = new ArrayList<Bullet>();
    this.shootSound = shootSound;
  }

  void keyPressed() {
    if (keyCode == 32) { // spacebar 
      this.shoot();
    }
  }

  void draw() {
    image(shipImage, frame.x, frame.y, frame.width, frame.height);

    if (keyPressed) {
      if (keyCode == LEFT) {
        if (frame.x > 0) {
          frame.x -= 3;
        }
      } else if (keyCode == RIGHT) {
        if (frame.x + frame.width < width) {
          frame.x += 3;
        }
      }
    }


    for (int i = 0; i < bullets.size(); ++i) {
      if (bullets.get(i).isHidden()) {
        bullets.remove(i);
      }
    }

    for (Bullet bullet : bullets) {
      bullet.move();
      bullet.draw();
    }
  }

  void shoot() {
    if (bullets.size() != MAX_BULLETS) {
      Bullet bullet = new Bullet(new Rect(frame.x + frame.width/2, frame.y - 5, 6, 17), color(255));
      bullets.add(bullet);
      //shootSound.play();
    }
  }

  Bullet[] bulletsShooting() {
    return bullets.toArray(new Bullet[bullets.size()]);
  }

  Rect frame() {
    return this.frame;
  }
}
