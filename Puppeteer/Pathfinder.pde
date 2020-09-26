import java.util.PriorityQueue;
import java.awt.Point;
import java.util.ArrayList;
import java.util.HashSet;

public class Node extends Point implements Comparable{
  public double f,g = 0;
  public int index;
  public HashSet<Integer> connections = new HashSet<Integer>();
  public int marked = 0;
  public AStar ref;
  public Tile tile;
  public Node(int x, int y,int index,AStar ref,Tile tile){
    super(x,y);
    this.tile = tile;
    this.ref=ref;
    this.index = index;
  }
  public void calculateF(Node prev,Node goal){
    g = (prev == null) ? 0 : prev.g + distance(prev);
    f = distance(goal) + g;
  }
  public void addConnection(Node other){
    connections.add(other.index);
    other.connections.add(index);
  }
  public boolean AStar(){
    if(this == ref.target) return true;
    ArrayList<Integer> toRemove = new ArrayList<Integer>();
    for (Integer i : connections) {
      //println(i);
      Node neigh = ref.data[i];
      neigh.calculateF(this,ref.target);
      ref.queue.add(neigh);
      neigh.marked = marked+1;
      toRemove.add(neigh.index);
    }
    //Already tested, no need to go back
    for(Integer i: toRemove){
      connections.remove(i);
      ref.data[i].connections.remove(index);
    }
    return false;
  }
  @Override
  public int compareTo(Object obj) {return (int) Math.signum(f-((Node)obj).f);}
  //Debug
  @Override
  public String toString(){
    return "Node #:" + index;
  }
}
public class AStar {
  PriorityQueue<Node> queue = new PriorityQueue<Node>();
  Node[] data;
  Node start, target;
  ArrayList<Node> path;
  Node[][]hasCreated=new Node[30][60];
  public AStar(Tile[][] tiles){
        ArrayList<Node> tmp = new ArrayList<Node>();
        hasCreated= new Node[30][60];
        path = new ArrayList<Node>();
        int k = 0;
        for(int i=0;i<29;i++){
          for(int j=0;j<60;j++){
            if(tiles[i][j].getID()== 0){
              Node qmp;
              if(hasCreated[i][j]==null){
                qmp = new Node(j,i,k++,this,tiles[i][j]);
                tmp.add(qmp);
                hasCreated[i][j] = qmp;
              }else {qmp = hasCreated[i][j];}
              if(j<59&&hasCreated[i][j+1]==null&&tiles[i][j+1].getID()==0){
                Node l=new Node(j+1,i,k++,this,tiles[i][j+1]);
                hasCreated[i][j+1] = l;
                qmp.addConnection(l);
                tmp.add(l);
              }
              if(hasCreated[i+1][j]==null&&tiles[i+1][j].getID()==0){
                Node d=new Node(j,i+1,k++,this,tiles[i+1][j]);
                hasCreated[i+1][j] = d;
                qmp.addConnection(d);
                tmp.add(d);
              }
            }
          }
        }
        int s=tmp.size();
        print(tmp.size());
        data = new Node[s];
        for(int i =0;i<s;i++){
          data[i] = tmp.get(i);
        }
        calculatePath(1,1,12,12);
  }
  public void calculatePath(int x1,int y1, int x2,int y2){
    start = hasCreated[y1][x1];
    target = hasCreated[y2][x2];
    println(start.index);
    //if(start == null || target == null)return;
    path.add(start);
    start.AStar();
    int i = 0;
    while(++i <= data.length){
      Node cr = queue.poll();
      if(cr.marked == path.size()){
        path.add(cr);
      }else{
        path.set(cr.marked,cr);
        for(int j= 0;j < path.size()-1;){
          System.out.print(path.get(j)+"->"+path.get(++j));
        }
        //println();
      }
      if(cr.AStar())break;
    }
    System.out.println("Finished with a total distance:"+ path.get(path.size()-1).g);
  }
}
