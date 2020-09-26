public class ImageList {
   HashMap<String, PImage> floorSprites;
  public ImageList() {
    floorSprites = new HashMap<String, PImage>();
    floorSprites.put("level_1",loadImage("Assets/1.png"));
    floorSprites.put("ground",loadImage("Assets/ground.png"));
    floorSprites.put("wall",loadImage("Assets/wall.png"));
    floorSprites.put("exit",loadImage("Assets/exit.png"));
    floorSprites.put("lava",loadImage("Assets/lava.jpg"));
    floorSprites.put("water",loadImage("Assets/water.png"));
  }
  
  public PImage getImage(String name){
    return floorSprites.get(name);
  }
}
