import java.awt.Point;
public class Tile {
  public static final int NO_NEIGHBOR = -1;
  public static final int NW_NEIGHBOR = 0;
  public static final int NORTH_NEIGHBOR = 1;
  public static final int NE_NEIGHBOR = 2;
  public static final int EAST_NEIGHBOR = 3;
  public static final int SE_NEIGHBOR = 4;
  public static final int SOUTH_NEIGHBOR = 5;
  public static final int SW_NEIGHBOR = 6;
  public static final int WEST_NEIGHBOR = 7;
  
  private boolean isFlagged;
  private boolean isMine;
  private Point point; // Probably going to be the x,y coords in the graphics...
  private int[] neighbors;
  private final int squareNum;
  
  public Tile(int num, int x, int y, boolean isMine) {
    squareNum = num;
    point = new Point(x,y);
    this.isMine = isMine;
    neighbors = new int[8];
    for (int i = 0; i < 8; i++) {
      neighbors[i] = -1;
    }
  }
  
  public void setNeighbor(int pos, int neighbor) {
     neighbors[pos] = neighbor; 
  }
  
  public boolean isMine() {
   return isMine; 
  }
  
  public boolean isFlagged() {
     return isFlagged; 
  }
  
  public void toggleFlagged() {
     isFlagged = !isFlagged; 
  }
  
  public int getSquareNum() {
     return squareNum; 
  }
}