public class Entity extends GameObject implements Physical{
  protected int health;
  protected PVector velocity;
  protected float maxVelocity=3;
  protected boolean isActive;
  protected Hitbox box;
  protected float ACCEL_CONSTANT = 0.1;
  protected float DECCEL_CONSTANT = 0.935;
  protected Hitbox dummyBox;
  public Entity(Level_Runner sc,Hitbox box,int health){
    super(sc);
    this.health = health;
    this.box = box;
    velocity = new PVector(0,0);
    maxVelocity = 3;
  }
  public Hitbox getHitbox(){
    return box;
  }
  protected void collisionResponse(){
  }
  protected void checkForCollision(){
    HashSet<GameObject> Boxes = sc.getObj(tag.SOLID);
    if(Boxes != null){
      for(GameObject i:Boxes){
        dummyBox = ((Physical)i).getHitbox();
        if(dummyBox.isHit(box)){
        
        }
      }
    }
  }
  protected void normalizeVelocity(){
    println(velocity.toString());
     if(velocity.mag() >= maxVelocity){
        velocity.setMag(maxVelocity);
     }
  }
  int update(){
    normalizeVelocity();
    velocity.mult(DECCEL_CONSTANT);
    box.translate(velocity);
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
  int update(){
    applyInput();
    super.update();
    return 0;
  }
  void render(){
    box.render();
  }
}
