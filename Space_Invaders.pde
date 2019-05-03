import processing.sound.*;

Alien aliens[];
Player player;
PImage alienImages[];
PImage explodedImage;
PImage backgroundImage;
PImage logoImage;
PImage shipImage;
SoundFile explodeSound;
SoundFile shootSound;
PFont font;
ArrayList<Bomb> bombsOnScreen;
GameState state;

void settings() {
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
}

void setup() {
  aliens = new Alien[MAX_NUMBER_OF_ALIENS];
  bombsOnScreen = new ArrayList<Bomb>();
  font = loadFont("ArcadeClassic-48.vlw");
  //explodeSound = new SoundFile(this, "explosion.wav");
  //shootSound = new SoundFile(this, "shoot.wav");

  state = GameState.ONBOARDING;

  explodedImage = loadImage("alien exploded.png");
  AlienType[] types = AlienType.values();

  for (int i = 0; i < aliens.length; ++i) {
    AlienType type = types[int(random(types.length))];
    int row = (i / ALIENS_PER_LINE);
    int column = row * ALIENS_PER_LINE;
    int positionX = (i - column) * (SPACING + ALIEN_SIZE);
    int positionY = row * (SPACING + ALIEN_SIZE);
    aliens[i] = new Alien(new Rect(positionX, positionY, ALIEN_SIZE, ALIEN_SIZE), type, explodedImage, explodeSound);
  }

  shipImage = loadImage("battleship.png");

  player = new Player(new Rect(width/2 - SHIP_SIZE/2, height - 10 - SHIP_SIZE, SHIP_SIZE, SHIP_SIZE), shipImage, 3, shootSound);

  backgroundImage = loadImage("background.png");
  logoImage = loadImage("logo.png");
}

void keyPressed() {
  if (keyCode == ESC) {
    state = GameState.PAUSED;
  } else if (state != GameState.PLAYING) {
    state = GameState.PLAYING;
  } else {
    player.keyPressed();
  }
}

void draw() {
  background(backgroundImage);

  switch (state) {
  case ONBOARDING:
    image(logoImage, width/2 - LOGO_SIZE/2, 20, LOGO_SIZE, LOGO_SIZE);
    fill(YELLOW);
    textFont(font);
    textAlign(CENTER, CENTER);
    text("PRESS ANY KEY TO START", width/2, 60 + LOGO_SIZE);
    return;
  case PLAYING: 
    {
      int numberOfExplodedAliens = 0;

      for (Bullet bullet : player.bulletsShooting()) {
        for (Alien alien : aliens) {
          if (!alien.hasExploded() && bullet.frame().intersects(alien.frame())) {
            alien.explode();
            bullet.hide();
            break;
          }
        }
      }

      for (Alien alien : aliens) {
        alien.move();

        numberOfExplodedAliens += alien.hasExploded() ? 1 : 0;

        Bomb bomb = alien.bomb();

        if (!alien.hasExploded() && alien.canDropBomb() && bombsOnScreen.size() < MAX_NUMBER_OF_BOMBS) {
          alien.dropBomb();
          bombsOnScreen.add(bomb);
        }

        if (bomb.frame().intersects(player.frame())) {
          bomb.hide();
          state = GameState.LOST;
        }

        if (bomb.isHidden()) {
          bombsOnScreen.remove(bomb);
        }

        alien.draw();
      }

      player.draw();

      if (numberOfExplodedAliens == aliens.length) state = GameState.WON;

      return;
    }
  case PAUSED:
    fill(YELLOW);
    textFont(font);
    textAlign(CENTER, CENTER);
    text("PAUSED", width/2, height/2);
    return;
  case LOST:
    fill(YELLOW);
    textFont(font);
    textAlign(CENTER, CENTER);
    text("GAME OVER", width/2, height/2);
    return;
  case WON:
    fill(YELLOW);
    textFont(font);
    textAlign(CENTER, CENTER);
    text("YOU WON!", width/2, height/2);
    return;
  default:
    return;
  }
}
