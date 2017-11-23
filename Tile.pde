import java.awt.Point;
import java.util.Arrays;

class Tile {
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
  private Tile[] neighbors;
  private final int squareNum;
  private boolean isRevealed;

  public Tile() {
    squareNum = Tile.NO_NEIGHBOR;
    isRevealed=false;
  }

  public Tile(int num, int x, int y, boolean isMine) {
    squareNum = num;
    point = new Point(x, y);
    this.isMine = isMine;
    neighbors = new Tile[8];
    for (int i = 0; i < 8; i++) {
      neighbors[i] = new Tile();
    }
    isRevealed = false;
  }

  public void setNeighbor(int pos, Tile neighbor) {
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
  public Point getPoint() {
    return point;
  }

  public void setPoint(Point point) {
    this.point = point;
  }

  public Tile[] getNeighbors() {
    return neighbors;
  }

  public void setNeighbors(Tile[] neighbors) {
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
    if (squareNum != tile.squareNum) {
      return false;
    }
    if (!point.equals(tile.point)) {
      return false;
    }
    // Probably incorrect - comparing Object[] arrays with Arrays.equals
    return Arrays.equals(neighbors, tile.neighbors);
  }

  @Override
    public int hashCode() {
    int result = (isMine ? 1 : 0);
    result = 31 * result + point.hashCode();
    result = 31 * result + Arrays.hashCode(neighbors);
    result = 31 * result + squareNum;
    return result;
  }
}