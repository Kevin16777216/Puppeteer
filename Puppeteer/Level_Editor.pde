public class Level_Editor extends Level_Loader{
  boolean hasOverlay = false;
  public Level_Editor(String s, readMode mode){
    super(s,mode);
    clear();
    background(255);
    tButton NextButton = new tButton(this,1520,970, 390, 100,1);
    NextButton.setButtonSprite("Assets/confirm.jpg",1520,970,390,100);
    tButton toggleOverlay = new tButton(this,10,970, 400,100,12);
    toggleOverlay.setButtonSprite("Assets/tile_swap.jpg",10,970,400,100);
    tButton statusButton = new tButton(this,43, 974, 143, 82, 0);
    statusButton.setButtonSprite("Assets/current_puppeteer.jpg",710,960,500,120);
    addObj(statusButton);
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
  private color[] mt = new color[]{color(255,255,0,122),color(255,255,255,122),color(255,0,0,122)};
  private int x,y,rx,ry,choice,choice2;
  private Level_Editor canvas;
  private boolean drawType;
  private int countRun;
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
    drawType =mousePressed&&valid;
    if(drawType){
      
      rx = x/32;
      ry = y/32;
      if(canvas.hasOverlay){
        switch(choice2){
          case 0:
            countRun = 0;
            canvas.setSpawn(rx,ry);
            break;
          case 1:
            canvas.removeEnemy(rx,ry);
            break;
          default:
            canvas.addEnemy(rx,ry,choice2-2);
        }
      }else{
        canvas.modifyTile(ry,rx,choice);
      }
    }
    if(keys.isPressed('a')){
      if(canvas.hasOverlay){
        choice2--;
        if(choice2 < 0) choice2 = mt.length-1;
      }else{
        choice--;
        if(choice < 0) choice = catalogue.size()-1;
      }
      
    }
    if(keys.isPressed('d')){
      if(canvas.hasOverlay){
        choice2++;
        if(choice2 == mt.length) choice2 = 0;
      }else{
        choice++;
        if(choice == catalogue.size()) choice = 0;
      }
    }
    catalogue.get(choice).setX(x-2);
    catalogue.get(choice).setY(y-2);
    return 0;
  }
  @Override
  void render(){
    //catalogue.get(choice).needLoad = true;
    int gx = (catalogue.get(choice).getX()+2)/32;
    int gy =(catalogue.get(choice).getY()+2)/32;
    fill(mt[0]);
    rect(canvas.px*32,canvas.py*32,16,32);
    //fill(mt[0]);
    if(canvas.hasOverlay){
      fill(mt[choice2]);
      rect(catalogue.get(choice).getX(),catalogue.get(choice).getY(),32,32);
      //fill(mt[choice2]);
    }else{
      catalogue.get(choice).render();
      catalogue.get(choice).needLoad = true;
    }
    canvas.refreshNeighbor(gx,gy);
  }
}
public class Level_Runner extends Level_Loader{
  public Level_Runner(String s, readMode mode){
    super(s,mode);
    Hitbox box = new Hitbox(new PVector(px*32,py*32),new PVector(30,30));
    Player mainPlayer = new Player(this,box,100);
    Button statusButton = new tButton(this,43, 974, 143, 82, 0);
    statusButton.setButtonSprite("Assets/current_puppet.jpg",710,960,500,120);
    addObj(mainPlayer);
    addObj(statusButton);
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
        if(n.player_type.equals("puppet")) {
          n.sendData("swap");
          n.changePlayerType();
          return 2;
        }
      default:
        return status;
    }
  }
}
