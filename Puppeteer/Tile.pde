public class Tile extends GameObject implements Physical{
  protected int x,y,id,w=32,h=32;
  static final int NUMBER_COLORS=5;
  Hitbox box;
  final color[] tileColors = {color(179, 130, 18),color(0,0,0),color(227, 90, 75),color(101, 196, 240),color(78, 194, 112)};
  boolean needLoad = true;
  PImage data;
  public Tile(Scene s,int x, int y, int id) {
    super(s);
    this.x = x;
    this.y = y;
    this.id = id;
    this.data = ImageList.getTile(id);
    box = new Hitbox(new PVector(x,y),new PVector(w,h));
    tags.add(tag.TILE);
    setupTag();
  }
  private void setupTag(){
    switch(id){
      case 1:
        tags.add(tag.SOLID);
        break;
      case 2:
        tags.add(tag.LAVA);
      case 3:
        tags.add(tag.WATER);
        break;
      case 4:
        tags.add(tag.EXIT);
        break;
    }
  }
  public int getID() {return id;}
  public void setID(int id){
    this.id = id;
    this.data = ImageList.getTile(id);
    
  }
  public Hitbox getHitbox(){return box;}
  public void setX(int x){this.x = x;}
  public void setY(int y){this.y = y;}
  public int getX(){return x;}
  public int getY(){return y;}
  public void setW(int w){this.w = w;}
  public void setH(int h){this.h = h;}
  void render() {
    //Choosing color based on ID
    if(needLoad){
      needLoad = false;
      image(data, x, y,32,32);
    }
  }
  int update() {return 0;}
}
