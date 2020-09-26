public class Level_Editor extends Level_Loader{
  boolean hasOverlay = false;
  public Level_Editor(String s, readMode mode){
    super(s,mode);
    clear();
    background(255);
    tButton NextButton = new tButton(this,1620, 970, 290, 100,1);
    tButton toggleOverlay = new tButton(this,1020,970, 200,100,12);
    addObj(NextButton);
    addObj(toggleOverlay);
    addObj(new Palette(this,960,480));
  }
  public boolean modifyTile(int x, int y, int id){
    switch(id){
      case 1:
        Tile tmp =new Tile(this, y*32,x*32,id);
        repObj(tiles[x][y],tmp);
        tiles[x][y]= tmp;
        break;
      default:
        tiles[x][y].setID(id);
    }
    return true;
  }
  int handleStatus(int status){
    switch(status){
      case 0:
        //addObj(tile)
      case 1:
        Meta = toString();
        //n.sendData(Meta);
        return 1;
      case 12:
        hasOverlay = !hasOverlay;
        return 0;
      default:
        return status;
    }
  }
}
public class Palette extends GameObject{
  private ArrayList<Tile> catalogue;
  private int x,y,rx,ry,choice;
  private Level_Editor canvas;
  private boolean draw;
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
      sc.addObj(tmp);
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
    draw =mousePressed&&valid;
    if(draw){
      
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
    //catalogue.get(choice).needLoad = true;
    catalogue.get(choice).render();
    int gx = (catalogue.get(choice).getX()+2)/32;
    int gy =(catalogue.get(choice).getY()+2)/32;
    canvas.refreshNeighbor(gx,gy);
    catalogue.get(choice).needLoad = true;
  }
}
public class Level_Runner extends Level_Loader{
  int timer = 20;
  public Level_Runner(String s, readMode mode){
    super(s,mode);
    Hitbox box = new Hitbox(new PVector(320,320),new PVector(30,30));
    Player mainPlayer = new Player(this,box,100);
    addObj(mainPlayer);
  }
    int handleStatus(int status){
    switch(status){
      case 0:
        //Consistently have the puppet send data for the livestream.
        if(n.player_type.equals("puppet")) {
          n.sendData(sendData());
        }
      case 1://Dead
        n.sendData("gameover");
        return 7;
      case 2://Out of time
        n.sendData("gameover");
        return 7;
      case 3://Success
        if(n.player_type.equals("puppeteer")) {
          n.sendData(sendData());
          return 8;
        }
      default:
        return status;
    }
  }
}
