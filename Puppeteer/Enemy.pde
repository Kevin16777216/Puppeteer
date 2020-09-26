public class Projectile extends Entity implements Physical{
  PVector velocity;
  public Projectile(Level_Loader s, PVector start,PVector velocity){
    super(s,new Hitbox(start, new PVector(10,10)),0);
    this.velocity = velocity;
    tags.add(tag.BULLET);
  }
  protected boolean checkCol(HashSet<Physical> Boxes){
    if(checkBounds())return true;
    if(Boxes != null)for(Physical i:Boxes){
      if(box.isHit(i.getHitbox())){
        if(i instanceof Player || i instanceof Enemy){
        }else{
          return true;
        }
      }
    }
    return false;
  }
  int update(){
    box.translate(velocity);
    if(checkCol(run.solidcache))sc.remObj(this);
    run.refreshNeighbor((int)(box.TR.x-box.TR.x%32)/32,(int)(box.TR.y-box.TR.y%32)/32);
    return 0;
  }
  Hitbox getHitbox(){
    return this.box;
  }
  void render(){
    fill(44,44,44);
    box.render();
  }
}
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
    if(random(0,50) < 1){
      shoot();
    }
    return 0;
  }
  private void shoot(){
    HashSet<GameObject> players = sc.getObj(tag.PLAYER);
    if(players != null){
      Player p = (Player)players.toArray()[0];
      PVector end = PVector.add(p.box.TR,PVector.mult(p.box.Dimensions,.5));
      PVector start = PVector.add(box.TR,PVector.mult(box.Dimensions,.5));
      PVector diff = PVector.sub(end,start);
      if(diff.mag()<400){
        diff.setMag(5);
        sc.addObj(new Projectile(ll,start,diff));
      }
    }
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
