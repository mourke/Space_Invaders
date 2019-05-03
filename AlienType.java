enum AlienType {
  MYSTERY(0), SAUCER(1), ALIEN(2), DEMON(3);

  private final int rawValue;

  private AlienType(int rawValue) {
    this.rawValue = rawValue;
  }

  public int rawValue() {
    return rawValue;
  }
}
