public class Button extends GameObject{
  private Hitbox box;
  private boolean isHover;
  private color borderColor = color(12);
  private color fillColor = color(255);
  private String text = "test";
  public Button(Scene ptr,int x, int y, int w, int h){
    this(ptr,new Hitbox(new PVector(x,y),new PVector(w,h)));
  }
  public Button(Scene ptr,Hitbox box){
    super(ptr);
    this.box = box;
    tags.add(tag.UI);
  }
  int update(){
    int status = 0;
    isHover = box.isHit(new PVector(mouseX,mouseY));
    if(isHover && mousePressed){
      status = action();
    }
    return status;
  }
  int action(){return 0;}
  void render(){
    rect(box.TR.x,box.TR.y,box.Dimensions.x,box.Dimensions.y);
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
