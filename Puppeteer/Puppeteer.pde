GameHandler handle;
KeyListener keys = new KeyListener();
long previous = System.nanoTime();
double lag = 0.0;
HashMap<Integer,key> input = new HashMap<Integer,key>();
Networking n = null;
ImageList ImageList;

void setup() {
  size(1920,1080);
  frameRate(4000);
  ImageList = new ImageList();
  handle = new GameHandler();
}

void draw() {
  long current = System.nanoTime();
  println((int)(1E9/(current-previous)));
  previous = current;
  handle.update();
  handle.render();
  keys.update();
  if(n != null){
    println(n.getPlayerType());
  }
}

public void keyPressed() {
  keys.keyUpdate(true);
}

public void keyReleased() {
  keys.keyUpdate(false);
}
