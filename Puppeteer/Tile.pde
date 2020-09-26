public class Tile extends GameObject{
  private int x,y,id,w=32,h=32;
  static final int NUMBER_COLORS=6;
  final color[] tileColors = {color(255,255,255),color(179, 130, 18),color(0,0,0),color(227, 90, 75),color(101, 196, 240),color(78, 194, 112)};
  public Tile(Scene s,int x, int y, int id) {
    super(s);
    this.x = x;
    this.y = y;
    this.id = id;
    tags.add(tag.TILE);
  }
  public int getID() {return id;}
  public void setID(int id){this.id = id;}
  public void setX(int x){this.x = x;}
  public void setY(int y){this.y = y;}
  public void setW(int w){this.w = w;}
  public void setH(int h){this.h = h;}
  void render() {
    //Choosing color based on ID
    fill(tileColors[id]);
    rect(x,y,w,h);
  }
  int update() {return 0;}
}
public class Palette extends GameObject{
  private ArrayList<Tile> catalogue;
  private int x,y,rx,ry,choice;
  private boolean draw = false;
  private Level_Editor canvas;
  public Palette(Level_Editor s, int x, int y){
    super(s);
    canvas = s;
    this.x = x;
    this.y = y;
    rx = x/32;
    ry = y/32;
    tags.add(tag.PALETTE);
    catalogue = new ArrayList<Tile>();
    for(int i = 0;i < Tile.NUMBER_COLORS;i++){
      Tile tmp = new Tile(sc, x-2,y-2,i);
      tmp.setH(39);
      tmp.setW(39);
      catalogue.add(tmp);
    }
    choice = 1;
  }
  @Override
  int update(){
    x=Math.max(Math.min(mouseX-mouseX%32,1888),0);
    y=Math.max(Math.min(mouseY-mouseY%32,928),0);
    boolean valid = true;
    HashMap<tag,HashSet<GameObject>> Buttons = canvas.getObj(new tag[]{tag.BUTTON});
    if(Buttons.containsKey(tag.BUTTON)){
      HashSet<GameObject> a= Buttons.get(tag.BUTTON);
      for(GameObject i:a){
        if(((Button)i).getHover()){
          valid= false;
          break;
        }
      }
    }
    if(mousePressed&&valid){
      draw = true;
      rx = x/32;
      ry = y/32;
      canvas.modifyTile(ry,rx,choice);
    }
    if(keys.isPressed('a')){
      choice--;
      if(choice < 0) choice = catalogue.size()-1;
    }
    if(keys.isPressed('d')){
      choice++;
      if(choice == catalogue.size()) choice = 0;
    }
    catalogue.get(choice).setX(x-2);
    catalogue.get(choice).setY(y-2);
    return 0;
  }
  @Override
  void render(){
    catalogue.get(choice).render();
  }
}
