import processing.sound.*;

class Alien {

  private Rect frame;
  private MovementDirection direction;
  private float oldYPos;
  
  private SoundFile explodeSound;
  private PImage alienImage;
  private PImage bombImage;
  private PImage explodeImage;
  private boolean exploded;
  private int explosionDuration = EXPLOSION_DURATION;
  private Bomb bomb;
  private AlienType type;

  Alien(Rect frame, AlienType type, PImage explodeImage, SoundFile explodeSound) {
    this.frame = frame;
    this.type = type;
    this.explodeSound = explodeSound;

    switch (type) {
    case MYSTERY:
      this.alienImage = loadImage("mystery.png");
      this.bombImage  = loadImage("mystery bomb.png");
      break;
    case SAUCER:
      this.alienImage = loadImage("saucer.png");
      this.bombImage  = loadImage("saucer bomb.png");
      break;
    case ALIEN:
      this.alienImage = loadImage("alien.png");
      this.bombImage  = loadImage("alien bomb.png");
      break;
    case DEMON:
      this.alienImage = loadImage("demon.png");
      this.bombImage  = loadImage("demon bomb.png");
      break;
    default:
      return;
    }

    this.explodeImage = explodeImage;
    this.direction = MovementDirection.RIGHT;
    this.exploded = false;
    this.bomb = new Bomb(new Rect(0, 0, 0, 0), bombImage);
    bomb.hide();
  }



  MovementDirection direction() {
    return this.direction;
  }

  void move() {
    switch (direction) {
    case LEFT:
      if (!isAtLeftWall()) {
        frame.x--;
      } else {
        direction = MovementDirection.DOWN;
        oldYPos = frame.y;
      }
      break;
    case RIGHT:
      if (!isAtRightWall()) {
        frame.x++;
      } else {
        direction = MovementDirection.DOWN;
        oldYPos = frame.y;
      }
      break;
    case DOWN:
      if (oldYPos + SPACING == frame.y) {
        if (isAtRightWall()) {
          direction = MovementDirection.LEFT;
        } else if (isAtLeftWall()) {
          direction = MovementDirection.RIGHT;
        }
      } else {
        frame.y++;
      }
      break;
    case UP:
      frame.y--; 
      break;
    }
  }

  private boolean isAtRightWall() {
    return frame.x + frame.width >= width;
  }

  private boolean isAtLeftWall() {
    return frame.x <= 0;
  }

  void explode() {
    exploded = true;
    //explodeSound.play();
  }

  boolean hasExploded() {
    return exploded;
  }

  private PImage currentImage() {
    if (hasExploded()) {
      return explosionDuration <= 0 ? null : explodedImage;
    } else {
      return alienImage;
    }
  }

  void dropBomb() {
    bomb.frame = new Rect(frame.x + frame.width/2, frame.y + frame.height, BOMB_SIZE, BOMB_SIZE);
    bomb.show();
  }

  boolean canDropBomb() {
    return bomb.isHidden();
  }

  Bomb bomb() {
    return bomb;
  }

  Rect frame() {
    return this.frame;
  }

  void draw() {
    PImage image = currentImage();

    if (image != null) {
      image(image, frame.x, frame.y, frame.width, frame.height);
    }

    if (hasExploded()) {
      explosionDuration--;
    }

    if (!bomb.isHidden()) {
      bomb.move();
      bomb.draw();
    }
  }
}
