public static enum Status{
  ERROR,
  GOOD,
}
public class GameHandler {
  final int DEFAULT_SCENE = 2;
  int resp;
  Scene cScene;
  Status state = Status.GOOD;
  public GameHandler() {
    loadScene(DEFAULT_SCENE);
  }
  private Scene getScene(int id) {
    switch (id) {
      //Enter Editor, Default Level
      case 0:
        if(n == null){
          n = new Networking("server");
          println("Set as server side.");
        }
        return new Level_Editor("Assets/1",readMode.IMG);
      //Enter Level from Editor.
      case 1:
        String lvlData = cScene.Meta;
        print(lvlData);
        return new Level_Runner(lvlData,readMode.STRING,true);
      //Main Menu
      case 2: 
        return new Main_Menu();
      case 3:
        return new Instructions();
      case 4:
        if(n == null){
          n = new Networking("client");
          println("Set as client side.");
        }
        return new WaitingScreen();
      case 5:
        return new DemoScene();
      case 6:
        return new Victory();
      case 7:
        return new Defeat();
    }
    return new DemoScene();
  }
  private void loadScene(int id) {
    cScene = getScene(id);
  }

  private void handleSignal(int code) {
    switch (code) {
      case -1:
        cScene.exit();
        exit();
      //Changes from Level Editor to Level Runner.
      case 1:
        cScene.exit();
        loadScene(1);
        break;
      //Changes to Level Editor from the Start Menu.
      case 2:
        cScene.exit();
        loadScene(0);
        break;
      //Instructions
      case 3:
        cScene.exit();
        loadScene(3);
        break;
      //Goes to Main Menu
      case 4:
        cScene.exit();
        loadScene(2);
        break;
      //Goes to Waiting Screen
      case 5:
        cScene.exit();
        loadScene(4);
        break;
      //Goes to Victory Screen
      case 6:
        cScene.exit();
        loadScene(6);
      case 7:
        cScene.exit();
        loadScene(7);
      default:
        //clean up other garbage
        cScene.exit();
        //load new Scene
        loadScene(code);
        break;
    }
  }
  public void update() {
    this.resp = this.cScene.update();
    //If scene returns 0, means normal operation This also means that people should never reach demo scene.
    if (this.resp!=0) {
      this.handleSignal(this.resp);
    }
  }
  public void render(){
    cScene.render();
  }
}
