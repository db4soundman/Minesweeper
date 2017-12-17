
import java.util.*;

public static class Tile {
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
  private MyPoint point; // Probably going to be the x,y coords in the graphics...
  private ArrayList<Tile> neighbors;
  private int squareNum;
  private boolean isRevealed;

  public Tile() {
    squareNum = Tile.NO_NEIGHBOR;
    isRevealed=false;
  }

  public Tile(int x, int y, boolean isMine) {
    squareNum = -1;
    point = new MyPoint(x, y);
    this.isMine = isMine;
    neighbors = new ArrayList<Tile>();
    
    isRevealed = false;
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
  public MyPoint getPoint() {
    return point;
  }

  public void setPoint(MyPoint point) {
    this.point = point;
  }

  public ArrayList<Tile> getNeighbors() {
    return neighbors;
  }
  
  public void setNeighbor(int x, Tile tile) {
    neighbors.add(tile);
  }

  public void setNeighbors(ArrayList<Tile> neighbors) {
    this.neighbors = neighbors;
  }

  public boolean isRevealed() {
    return isRevealed;
  }

  public void setRevealed(boolean revealed) {
    isRevealed = revealed;
  }



  @Override
    public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }

    Tile tile = (Tile) o;

    if (isMine != tile.isMine) {
      return false;
    }
    //if (squareNum != tile.squareNum) {
    //  return false;
    //}
    if (!point.equals(tile.point)) {
      return false;
    }
    // Probably incorrect - comparing Object[] arrays with Arrays.equals
    return neighbors.equals(tile.neighbors);
  }

  @Override
    public int hashCode() {
    int result = (isMine ? 1 : 0);
    result = 31 * result + point.hashCode();
//    result = 31 * result + neighbors.hashCode();
    //result = 31 * result + squareNum;
    return result;
  }

  public void calculateSquareNum() {
    if (isMine) {
      squareNum = -1;
    } else {
      int sum = 0;
      for (Tile t: neighbors) {
        if (t.isMine()) {
          sum++;
        }
      }
      squareNum = sum;
    }
  }
  public int getCost() {
    return 1;
  }
}