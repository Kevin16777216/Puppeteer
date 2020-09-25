public class DemoScene extends Scene{

  public DemoScene() {
  }
  void init() {
    tButton test =new tButton(this,70, 70, 155, 155,5);
    addObj(test);
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
