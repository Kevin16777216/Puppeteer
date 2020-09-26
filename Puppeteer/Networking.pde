import processing.net.*;

public class Networking extends PApplet {
  Server s;
  Client c;
  String type;
  
  public Networking(String type) {
    if(type.equals("server")) {
      s = new Server(this, 12345);
    }
    else if(type.equals("client")) {
      c = new Client(this, "192.168.2.158",12345);
    }
    this.type = type;
  }
  
  public String sendData(String data){
    if(type.equals("server")) {
      s.write(data);
      return "Server Sent " + data;
    }
    else if(type.equals("client")){
      c.write(data);
      return "Client Sent " + data;
    }
    //Means there is an error.
    return "No data read!";
  }
  
  public String getData(){
    if(type.equals("server")) {
      c = s.available();
      if(c != null) {
        return c.readString();
      }
    }
    else if(type.equals("client")) {
      if(c.available() > 0) {
        return c.readString();
      }
    }
    return "No data read!";
 }
}
