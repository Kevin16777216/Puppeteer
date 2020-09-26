import java.util.Arrays;

public class Level_Loader extends Scene{
  Tile[][] tiles = new Tile[30][60];
  int level;
  //Enemies[] enemies;
  
  //String s can either be the string data itself OR the image. 
  public Level_Loader(String s, readMode mode){
    if(mode == readMode.IMG){
      s =imageToString(s);
    }
    clearLevel();
    //Example String: "[[1,3,2,3,4,3],[1,2,3,4,3,2,1]]:(Monster,4,3):(Monster,6,3):"
    //Splits the string into a 2D Array of Strings. (First is for Tiles, The Rest are for Enemies)
    String[] string_data = s.split(":");
    float[][] tile_data = toFloatArray(string_data[0]);
    for(int x = 0; x < tile_data.length; x++){
      for(int y = 0; y < tile_data[x].length; y++) {
        //The reason why it's inputted as y,x is because x represents the # of rows while y represents the # of columns.
        //Increasing Rows --> Vertical Displacement, Increasing Columns --> Horizontal Displacement.
        int id =(int)tile_data[x][y];
        Tile tmp;
        if(id == 1){
          tmp = new Wall(this, y*32,x*32,id);
        }else{
          tmp = new Tile(this, y*32,x*32,id);
        }
        tiles[x][y] = tmp;
        addObj(tmp);
      }
    }
  }
    
  public float[][] toFloatArray(String data){
    String [] array = data.replaceAll("[\\[ ]+", "").split("],");
    float [][] floatArray = new float[array.length][];
    for(int i = 0; i < array.length; i++){
        String [] row = array[i].split("\\D+");
        floatArray[i] = new float[row.length];
        for(int j = 0; j < row.length; j++){
            floatArray[i][j] = Float.valueOf(row[j]);
        }           
    }
    return floatArray;
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
  public Tile[] nearbyTiles(){
    return null;
  }
  public String toString() {
    //return Arrays.deepToString(tiles);
    String ret_string = "[[";
    for(int x = 0; x < 30; x++) {
      for(int y = 0; y < 60; y++) {
        ret_string += Integer.toString(tiles[x][y].getID());
         if(y != 59) {
           ret_string += ",";
         }
      }
      if(x != 29) {
        ret_string += "], [";
      }
      else {
        ret_string += "]]";
      }
    }
    return ret_string;
  }
  
  public String imageToString(String level_name){
    String ret_string = "[[";
    PImage myImage = loadImage(level_name+".png");
    image(myImage, 0, 0);
    for(int x = 0; x < 30; x++) {
      for(int y = 0; y < 60; y++) {
         //Reason why it's y, x is because of reason in Tile.
         color c = get(y,x);
         int red_col = (int)red(c);
         switch(red_col) {
           //Brown
           case 185:
             ret_string += "0";
             break;
           //Black Wall
           case 0:
             ret_string += "1";
             break;
           case 237:
             ret_string += "2";
             break;
           //Dark Blue
           case 63:
             ret_string += "3";
             break;
           case 34:
             ret_string += "4";
             break; 
         }
         if(y != 59) {
           ret_string += ",";
         }
      }
      if(x != 29) {
        ret_string += "], [";
      }
      else {
        ret_string += "]]";
      }
    }
    return ret_string;
  }
  
  //Used to send data to another player in the form of a string.
  public String sendData() {
    return toString();
  }
  
  //void render() {
  //  for(int x = 0; x < tiles.length; x++) {
  //    for(int y = 0; y < tiles[x].length; y++){
  //      if(tiles[x][y] != null) {
  //        tiles[x][y].render();
  //      }
  //    }
  //  }
  //}
  
  //Clears all Tiles and sets it to a new 2D array of Tiles.
  void clearLevel() {
    tiles = new Tile[30][60];
  }
  
}
