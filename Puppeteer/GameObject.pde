
public class GameObject {
   ArrayList<tag> tags;
   Scene sc;
  public GameObject(Scene sc){
    this.sc = sc;
    tags = new ArrayList<tag>();
    tags.add(tag.DEFAULT);
  }
  int update(){ //<>//
    int status = 0;
    //Do work, call Scene functions(like grab all tiles to check for collision)
    return status;
  }
  void render(){
  }
  public ArrayList<tag> getTags(){
    return tags;
  }
}
