public class Level_Editor extends Level_Loader{
  public Level_Editor(String s, readMode mode){
    super(s,mode);
    addObj(new Palette(this,960,480));
    tButton NextButton = new tButton(this,1620, 970, 290, 100,1);
    addObj(NextButton);
  }
  public boolean modifyTile(int x, int y, int id){
    tiles[x][y].setID(id);
    return true;
  }
  int handleStatus(int status){
    switch(status){
      case 0:
        //addObj(tile)
      case 1:
        Meta = toString();
        n.sendData(Meta);
        return 1;
      default:
        return status;
    }
  }
}
public class Level_Runner extends Level_Loader{
  public Level_Runner(String s, readMode mode){
    super(s,mode);
    //Hitbox box = new Hitbox(new PVector)
    //Player mainPlayer = new Player(this);
  }

}
