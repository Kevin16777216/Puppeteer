public class Enemy extends GameObject {
  int x;
  int y;
  int id;
  public Enemy(Scene s, int x, int y, int id) {
    super(s);
    this.x = x;
    this.y = y;
    this.id = id;
  }
  
  public int getX(){
    return x;
  }
  
  public int getY(){
    return y;
  }
  
  public int getID(){
    return id;
  }
}
