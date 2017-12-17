import java.awt.Point;

/**
 * 
 */

/**
 * @author Doug Blase
 *
 */
public static class MyPoint extends Point implements Comparable<MyPoint> {
  private final int x, y;

  public MyPoint(int x, int y) {
    super(x, y);
    this.x = x;
    this.y = y;
  }

  /**
   * @return the x
   */
  public int getXCoord() {
    return x;
  }

  /**
   * @return the y
   */
  public int getYCoord() {
    return y;
  }

  public String toString() {
    return "(" + x + ", " + y + ")";
  }

  public int hashCode() {
    return super.hashCode();
  }

  /*
   * (non-Javadoc)
   * 
   * @see java.lang.Comparable#compareTo(java.lang.Object)
   */
  @Override
  public int compareTo(MyPoint o) {
    double distanceFromOrigin = (this.distance(new Point(0, 0))
        - o.distance(new Point(0, 0)));
    if (distanceFromOrigin != 0) {
      return distanceFromOrigin > 0 ? 1 : -1;
    }
    return this.y - o.y;
  }
}