public class Level_Editor extends Level_Loader{
  public Level_Editor(String s, readMode mode){
    super(s,mode);
    addObj(new Palette(this,960,480));
    tButton NextButton = new tButton(this,1620, 970, 290, 100,1);
    addObj(NextButton);
  }
  public boolean modifyTile(int x, int y, int id){
    switch(id){
      case 1:
        Wall tmp =new Wall(this, y*32,x*32,id);
        tiles[x][y]= tmp;
        addObj(tmp);
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
      default:
        return status;
    }
  }
}
public class Level_Runner extends Level_Loader{
  boolean is_puppeteer;
  public Level_Runner(String s, readMode mode, boolean is_puppeteer){
    super(s,mode);
    Hitbox box = new Hitbox(new PVector(320,320),new PVector(30,30));
    Player mainPlayer = new Player(this,box,100);
    addObj(mainPlayer);
    this.is_puppeteer = is_puppeteer;
  }
    int handleStatus(int status){
    switch(status){
      case 0:
        //addObj(tile)
      case 1://Dead
      if(is_puppeteer){
        return 7;
      }
      else {
        return 6;
      }
      case 2://Out of time
        if(is_puppeteer){
          return 7;
        }
        else{
          return 6;
        }
      case 3://Success
        if(is_puppeteer) {
          n.sendData(Meta);
          return 4;
        }
      default:
        return status;
    }
  }
}
