GameHandler handle = new GameHandler();
KeyListener keys = new KeyListener();
double previous = millis();
double lag = 0.0;

void setup() {
  size(1920,1080);
}

void draw() {
  keys.update();
  clear();
  background(255);
  handle.update();
  handle.render();
}

public void keyPressed() {
  keys.keyUpdate(true);
}

public void keyReleased() {
  keys.keyUpdate(false);
}
