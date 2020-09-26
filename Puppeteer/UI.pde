public class Button extends GameObject{
  private Hitbox box;
  private boolean isHover;
  private color borderColor = color(12);
  private color fillColor = color(235);
  private String text = "test";
  private boolean down;
  private boolean ready;
  private PImage button_sprite;
  private int button_x_loc;
  private int button_y_loc;
  private int button_x;
  private int button_y;
  public Button(Scene ptr,int x, int y, int w, int h){
    this(ptr,new Hitbox(new PVector(x,y),new PVector(w,h)));
  }
  public Button(Scene ptr,Hitbox box){
    super(ptr);
    this.box = box;
    tags.add(tag.UI);
    tags.add(tag.BUTTON);
  }
  
  void setButtonSprite(String img_name, int x_loc, int y_loc, int x_size, int y_size){
    button_sprite = loadImage(img_name);
    button_x_loc = x_loc;
    button_y_loc = y_loc;
    button_x = x_size;
    button_y = y_size;
  }
  
  int update(){
    int status = 0;
    isHover = box.isHit(new PVector(mouseX,mouseY));
    //if(isHover&&ready)
    if(isHover && mousePressed && !down){
      status = action();
    }
    down = mousePressed;
    return status;
  }
  boolean getHover(){return isHover=box.isHit(new PVector(mouseX,mouseY));}
  int action(){return 0;}
  void render(){
    if(button_sprite != null) {
      image(button_sprite,button_x_loc,button_y_loc,button_x,button_y);
    }
    else{
      rect(box.TR.x,box.TR.y,box.Dimensions.x,box.Dimensions.y);
    }
  }
}
//transition button
public class tButton extends Button{
  int sc = 0;
  public tButton(Scene ptr,int x, int y, int w, int h,int Scene){
    this(ptr,new Hitbox(new PVector(x,y),new PVector(w,h)),Scene);
  }
  public tButton(Scene ptr,Hitbox box, int Scene){
    super(ptr,box);
    sc = Scene;
  }
  int action(){
    return sc;
  }
}
public class Bar extends GameObject{
  PVector pos;
  PVector Dimensions;
  color full = color(0,255,0);
  color empty = color(255,0,0);
  color border = 55;
  float max;
  float value;
  public Bar(Scene sc, PVector pos, PVector Dimensions, float max){
    super(sc);
    this.max = max;
    this.pos = pos;
    this.Dimensions = Dimensions;
    value = max;
  }
  public void render(){
    fill(empty);
    stroke(border);
    strokeWeight(5);
    rect(pos.x,pos.y, Dimensions.x,Dimensions.y);
    fill(full);
    rect(pos.x,pos.y, Dimensions.x * (value /max),Dimensions.y);
    strokeWeight(1);
  }
  public void updateValue(float value){
    this.value = value;
  } 
}
