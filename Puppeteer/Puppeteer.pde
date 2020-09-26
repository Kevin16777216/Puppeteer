GameHandler handle;
KeyListener keys = new KeyListener();
double previous = millis();
double lag = 0.0;
HashMap<Integer,key> input = new HashMap<Integer,key>();
void setup() {
  size(1920,1080);
  frameRate(4000);
  handle = new GameHandler();
}

void draw() {
  double current = millis();
  //println((int)(1000/(current-previous)));
  previous = current;
  clear();
  background(255);
  handle.update();
  handle.render();
  keys.update();
}

public void keyPressed() {
  keys.keyUpdate(true);
}

public void keyReleased() {
  keys.keyUpdate(false);
}
