public class Entity extends GameObject{
  private int health;
  private PVector velocity;
  private float maxVelocity;
  private boolean isActive;
  private Hitbox box;
  private float ACCEL_CONSTANT = 1.05;
  private float DECCEL_CONSTANT = 0.94;
  public Entity(Level_Loader sc,Hitbox box,int health){
    super(sc);
    this.box = box;
  }
  int update(){
    if(!isActive){
      velocity.mult(DECCEL_CONSTANT);
    }
    return 0;
  }
}
public class Player extends Entity{
  public Player(Level_Loader sc,Hitbox box,int health){
    super(sc,box,health);
  }
}
