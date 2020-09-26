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
  println("FPS: " +(int)(1E9/(current-previous)));
  previous = current;
  handle.update();
  handle.render();
  keys.update();
//<<<<<<< HEAD
//  if(n != null){
//    //println(n.getPlayerType());
//=======
//  /*if(n != null){
//    println(n.getPlayerType());
//>>>>>>> 7f79068973cb464c7e23e24d3d87e03252287d9c
//  }
//  */
//  //println(mouseX + "," + mouseY + "\n");
}

public void keyPressed() {
  keys.keyUpdate(true);
}

public void keyReleased() {
  keys.keyUpdate(false);
}
