public class Tile extends GameObject{
  int x;
  int y;
  int id;

  public Tile(Scene s,int x, int y, int id) {
    super(s);
    this.x = x;
    this.y = y;
    this.id = id;
  }

  public int getX() {
    return x;
  }

  public int getY() {
    return y;
  }

  public int getID() {
    return id;
  }

  public String toString() {
    return Integer.toString(getID());
  }

  
  void render() {
      //Choosing color based on ID
      switch (id) {
        case 0:
          //White Empty Space
          fill(255,255,255);
          break;
        case 1:
          //Brown Ground
          fill(179, 130, 18);
          break;
        case 2:
          //Black Wall
          fill(0,0,0);
          break;
        case 3:
          //Lava 
          fill(227, 90, 75);
          break;
        case 4:
          //Water
          fill(101, 196, 240);
          break;
        case 5:
          //Green Exit
          fill(78, 194, 112);
          break;
      }
      rect(getX()*32,getY()*32,32,32);
 }

  int update() {
    return 0;
  }
} 
