import java.util.Arrays;

public class Level_Loader extends Scene{
  Tile[][] tiles = new Tile[30][60];
  int level;
  int px,py=px=2;
  int timer = 20;
  ArrayList<Enemy> enemies = new ArrayList<Enemy>();
  HashSet<Physical> solidcache;
  //HashSet<Physical> solidcache;
  //String s can either be the string data itself OR the image. 
  public Level_Loader(String s, readMode mode){
    if(mode == readMode.IMG){
      s =imageToString(s);
    }
    solidcache = new HashSet<Physical>();
    //Example String: "[[1,3,2,3,4,3],[1,2,3,4,3,2,1]]:[4,3]:[[0,4,3],[1,6,3]]"
    //The last value of the monster 2D array is the type/id.
    //Splits the string into a 2D Array of Strings. (First is for Tiles, The Rest are for Enemies)
    String[] string_data = s.split(":");
    float[][] tile_data = toFloatArray(string_data[0]);
    for(int x = 0; x < tile_data.length; x++){
      for(int y = 0; y < tile_data[x].length; y++) {
        //The reason why it's inputted as y,x is because x represents the # of rows while y represents the # of columns.
        //Increasing Rows --> Vertical Displacement, Increasing Columns --> Horizontal Displacement.
        int id =(int)tile_data[x][y];
        Tile tmp;
        tmp = new Tile(this, y*32,x*32,id);
        tiles[x][y] = tmp;
        addObj(tmp);
      }
    }
    if(string_data.length>1){
       int[] p_loc =toIntArray(string_data[1]);
       px = p_loc[0];
       py = p_loc[1];
       if(string_data.length>2){
         float[][] monster_data = toFloatArray(string_data[2]);
         for(int x = 0; x < monster_data.length; x++){
           int x_cor = (int)monster_data[x][0];
           int y_cor = (int)monster_data[x][1];
           int id = (int)monster_data[x][2];
           Enemy tmp = new Enemy(this,x_cor*32,y_cor*32,id);
           addObj(tmp);
           enemies.add(tmp);
         }
       }
    }
  }
  int update(){
    int out = super.update();
    solidcache.clear();
    HashSet<GameObject> tmp=getObj(tag.SOLID);
    for(GameObject i:tmp){
      solidcache.add((Physical)i);
    }
    return out;
    
  }
  public void refreshTile(int x, int y){
    tiles[x][y].needLoad = true;
  }
  public void addEnemy(int x, int y, int id){
    if(findEnemy(x, y) == -1){
      Enemy tmp = new Enemy(this,x*32,y*32,id);
      addObj(tmp);
      enemies.add(tmp);
    }
  }
  public int findEnemy(int x, int y){
    for(int i =0;i<enemies.size();i++){
      Enemy tmp = enemies.get(i);
      int gx =(int)(tmp.getX()-tmp.getX()%32)/32;
      int gy =(int)(tmp.getY()-tmp.getY()%32)/32;
      if(gx ==x &&gy == y)return i;
    }
    return -1;
  }
  public void removeEnemy(int x, int y){
    int res = findEnemy(x,y);
    if(res!=-1){
      remObj(enemies.remove(res));
    }
  }
  public void refreshNeighbor(int gx, int gy){
    int w=Math.min(gx+3,60);
    int r=Math.max(gy-2,0);
    int h =Math.min(gy+3,30);
    
    for(int i =Math.max(gx-2,0);i<w;++i){
      for(int j = r;j<h;++j){
        tiles[j][i].needLoad = true;
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
  public void setSpawn(int x, int y){
    refreshTile(py,px);
    px=x;
    py=y;
  }
  public int[] toIntArray(String data){
    String[] items = data.replaceAll("\\[", "").replaceAll("\\]", "").replaceAll("\\s", "").split(",");
    int[] results = new int[items.length];
    for (int i = 0; i < items.length; i++) {
    try {
        results[i] = Integer.parseInt(items[i]);
    } catch (NumberFormatException nfe) {
        //NOTE: write something here if you need to recover from formatting errors
    };
    }
    return results;
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
        ret_string += "]]:[";
      }
    }
    ret_string+=Integer.toString(px)+","+Integer.toString(py)+"]";
    if(enemies.size()>0){
      String en_string = ":[";
      Enemy tmp;
      for(int i = 0;i <enemies.size();i++) {
        tmp =enemies.get(i);
        int gx =(int)(tmp.getX()-tmp.getX()%32)/32;
        int gy =(int)(tmp.getY()-tmp.getY()%32)/32;
        en_string+="["+gx+","+gy+","+tmp.id+"]";
        if(i == enemies.size()-1)break;
        en_string+=",";
      }
      en_string+="]";
      ret_string+=en_string;
    }
    return ret_string;
    /*
    //Add Player Location...
    ret_string += "[" + player_location[0] + "," + player_location[1] + "]:";
    //Add Monster Locations.  
    ret_string += "[[";
    for(int i = 0; i < enemies.size(); i++) {
      ret_string += enemies.get(i).getX();
      ret_string += "," + enemies.get(i).getY();
      ret_string += "," + enemies.get(i).getID() + "]";
      if(i != enemies.size() - 1) {
        ret_string += ",[";
      }
      else{
        ret_string += "]";
      }
    }
    return ret_string;
    */
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
