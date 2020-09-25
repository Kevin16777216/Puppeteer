public class DemoScene extends Scene{

  public DemoScene() {
  }
  void init() {
    tButton startGameButton =new tButton(this,70, 70, 155, 155,5);
    addObj(startGameButton);
  }
  int handleStatus(int status){
    switch(status){
      case 0:
        //addObj(tile)
      case 1:
        //etc..
      default:
        return status;
    }
  }
}
