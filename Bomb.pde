class Bomb {
  private Rect frame;
  private PImage bombImage;
  private boolean hidden;

  Bomb(Rect frame, PImage image) {
    this.frame = frame;
    this.bombImage = image;
    this.hidden = false;
  }

  void move() {
    frame.y += 4;
  }

  void draw() {
    image(bombImage, frame.x, frame.y, frame.width, frame.height);
    
    if (frame.y > height) {
      hide();
    }
  }

  Rect frame() {
    return this.frame;
  }

  void hide() {
    hidden = true;
    frame = new Rect(0, 0, 0, 0);
  }
  
  void show() {
    hidden = false;
  }

  boolean isHidden() {
    return hidden;
  }
}
