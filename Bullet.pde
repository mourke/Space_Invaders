class Bullet {

  private Rect frame;
  private color bulletColor;
  private boolean hidden;

  Bullet(Rect frame, color bulletColor) {
    this.frame = frame;
    this.bulletColor = bulletColor;
    this.hidden = false;
  }

  void move() {
    frame.y -= 10;
  }

  void draw() {
    fill(bulletColor);
    rect(frame.x, frame.y, frame.width, frame.height);

    if (frame.y < 0) {
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

  boolean isHidden() {
    return hidden;
  }
}
