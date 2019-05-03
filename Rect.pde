class Rect {
  float x, y, height, width;
  
  Rect(float x, float y, float width, float height) {
    this.x = x;
    this.y = y;
    this.height = height;
    this.width = width;
  }
  
  boolean intersects(Rect otherRect) {
    boolean isInsideHeight = (this.y >= otherRect.y && this.y <= otherRect.y + otherRect.height) || (this.y + this.height >= otherRect.y && this.y <= otherRect.y + otherRect.height);
    boolean isInsideWidth = this.x >= otherRect.x && this.x <= otherRect.x + otherRect.width;
    
    return isInsideHeight && isInsideWidth;
  }
}
