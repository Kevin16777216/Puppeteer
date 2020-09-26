public class Entity extends GameObject implements Physical{
  protected int health;
  protected Bar healthBar;
  protected PVector velocity;
  protected float maxVelocity=2;
  protected boolean isActive;
  protected Hitbox box;
  protected float ACCEL_CONSTANT = 0.07;
  protected float DECCEL_CONSTANT = 0.935;
  protected Hitbox dummyBox;
  protected Level_Runner run;
  public Entity(Level_Runner sc,Hitbox box,int health){
    super(sc);
    this.run =sc;
    this.health = health;
    this.box = box;
    velocity = new PVector(0,0);
    healthBar = new Bar(sc, this.box.TR, new PVector(64,10), health);
    maxVelocity = 3;
  }
  public Hitbox getHitbox(){
    return box;
  }
  protected boolean checkCol(HashSet<GameObject> Boxes){
    if(checkBounds())return true;
    if(Boxes != null)for(GameObject i:Boxes)if(box.isHit(((Physical)i).getHitbox()))return true;
    return false;
  }
  protected boolean checkBounds(){
    if(box.TR.x<0 || box.TR.y<0||box.TR.y+box.Dimensions.y > 960 ||box.TR.x+box.Dimensions.x>1920)return true;
    return false;
  }
  protected void checkForCollision(){
    HashSet<GameObject> Boxes = sc.getObj(tag.SOLID);
    Hitbox clone = new Hitbox(box.TR.copy(),box.Dimensions.copy());
    box.TR.x+= velocity.x;
    if(checkCol(Boxes))box.TR = clone.TR.copy();
    clone.TR = box.TR.copy();
    box.TR.y+= velocity.y;
    if(checkCol(Boxes))box.TR = clone.TR.copy();
  }
  protected void normalizeVelocity(){
     if(velocity.mag() >= maxVelocity){
        velocity.setMag(maxVelocity);
     }
  }
  int update(){
    normalizeVelocity();
    velocity.mult(DECCEL_CONSTANT);
    checkForCollision();
    return 0;
  }
}
public class Player extends Entity{
  public Player(Level_Runner sc,Hitbox box,int health){
    super(sc,box,health);
  }
  private void applyInput(){
    if(keys.isHeld('d'))velocity.x+=ACCEL_CONSTANT;
    if(keys.isHeld('a'))velocity.x-=ACCEL_CONSTANT;
    if(keys.isHeld('w'))velocity.y-=ACCEL_CONSTANT;
    if(keys.isHeld('s'))velocity.y+=ACCEL_CONSTANT;
  }
  private boolean checkLava(){
    HashSet<GameObject> lava = sc.getObj(tag.LAVA);
    return checkCol(lava);
  }
  private boolean checkExit(){
    HashSet<GameObject> exit = sc.getObj(tag.EXIT);
    return checkCol(exit);
  }
  int update(){
    applyInput();
    super.update();
    int gx =(int)(box.TR.x-box.TR.x%32)/32;
    int gy =(int)(box.TR.y-box.TR.y%32)/32;
    run.refreshNeighbor(gx,gy);
    healthBar.pos =new PVector(box.TR.x-16,box.TR.y-16);
    if(checkLava())return 1;
    if(checkExit())return 3;
    if(run.timer<0)return 2;
    return 0;
  }
  void render(){
    healthBar.render();
    box.render();
  }
}
