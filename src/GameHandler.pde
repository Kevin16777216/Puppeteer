public static enum Status{
  ERROR,
  GOOD,
}
public class GameHandler {
  final int DEFAULT_SCENE = 0;
  int resp = 0;
  Scene cScene;
  Status state = Status.GOOD;
  public GameHandler() {
    loadScene(DEFAULT_SCENE);
  }
  private Scene getScene(int id) {
    switch (id) {
      case 0:
        return new DemoScene();
      case 5:
        return new DemoScene();
    }
    return new DemoScene();
  }
  private void loadScene(int id) {
    cScene = getScene(id);
  }

  private void handleSignal(int code) {
    switch (code) {
      //Error
      case 1:
        cScene.exit();
        exit();
        break;
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
