public class ImageList {
   HashMap<String, PImage> floorSprites;
  public ImageList() {
    floorSprites = new HashMap<String, PImage>();
    floorSprites.put("level_1",loadImage("Assets/1.png"));
    floorSprites.put("ground",loadImage("Assets/ground.png"));
    floorSprites.put("wall",loadImage("Assets/wall.png"));
    floorSprites.put("exit",loadImage("Assets/exit.png"));
    floorSprites.put("lava",loadImage("Assets/lava.png"));
    floorSprites.put("water",loadImage("Assets/water.png"));
  }
  
  public PImage getImage(String name){
    return floorSprites.get(name);
  }
  public PImage getTile(int id){
    switch(id){
      case 0:
        return floorSprites.get("ground");
      case 1:
        return floorSprites.get("wall");
      case 2:
        return floorSprites.get("lava");
      case 3:
        return floorSprites.get("water");
      case 4:
        return floorSprites.get("exit");
      default:
        return floorSprites.get("ground");
    }
  }
}
