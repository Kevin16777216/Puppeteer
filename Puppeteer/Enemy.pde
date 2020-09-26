public class Enemy extends Entity{
  int id;
  boolean renderMode;
  private Level_Loader ll;
  public Enemy(Level_Loader s, int x, int y, int id) {
    super(s,new Hitbox(new PVector(x,y),new PVector(32,32)),140);
    ll=s;
    this.id = id;
    renderMode = s instanceof Level_Editor;
    tags.add(tag.ENEMY);
    tags.add(tag.SOLID);
  }
  
  public float getX(){
    return box.TR.x;
  }
  
  public float getY(){
    return box.TR.y;
  }
  
  public int getID(){
    return id;
  }
  public int update(){
    super.update();
    return 0;
  }
  public void render(){
      if(!renderMode){
        healthBar.render();
      }
      fill(color(255,0,0,122));
      rect(box.TR.x, box.TR.y,32,32);
      //fill(color(255,0,0,122));
    
  }
}
