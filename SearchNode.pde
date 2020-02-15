import java.awt.Point;
import java.util.TreeSet;

/**
 * A class that represents a node being searched via one of the search algorithms.
 */

/**
 * @author Doug Blase
 *
 */
public static class SearchNode implements Comparable<SearchNode> {
  private MyPoint coordinates;
  private double cost;
  private SearchNode parent;
  private Tile mapLocation;

  @SuppressWarnings("unchecked")
    public SearchNode(Tile srcNode, SearchNode p)
    throws Exception {
    coordinates = srcNode.getPoint();
    if (p != null) {
      cost = p.getCost() + srcNode.getCost();
      // We are not the root of the search, assign data from
      // parent.
      parent = p;
      //action = determineAction();
      //messagesVisited = (TreeSet<MyPoint>) parent
      //  .getMessagesVisited().clone();
    } else {
      cost = 0;
      // We are the root node, initialize data to be empty.
    //  action = "";
      //messagesVisited = new TreeSet<MyPoint>();
    }
    mapLocation = srcNode;
  }

  /**
   * Determines the direction moved to reach this SearchNode.
   * 
   * @return A string indicating the cardinal direction moved.
   * @throws Exception
   *             If the search algorithm didn't move. This primarily
   *             for error checking purposes.
   */
  //private String determineAction() throws Exception {
  //  Point diff = new Point(
  //    coordinates.getXCoord()
  //    - parent.getCoordinates().getXCoord(), 
  //    coordinates.getYCoord()
  //    - parent.getCoordinates().getYCoord());
  //  if (diff.equals(new Point(1, 0))) {
  //    return "N";
  //  }
  //  if (diff.equals(new Point(-1, 0))) {
  //    return "S";
  //  }
  //  if (diff.equals(new Point(0, 1))) {
  //    return "E";
  //  }
  //  if (diff.equals(new Point(0, -1))) {
  //    return "W";
  //  }
  //  throw new Exception("We didn't move...");
  //}

  /**
   * Updates the goal state of this node.
   */
  public void updateStatus() {
    //if (hasMessage()) {
    //  if (!messagesVisited.contains(coordinates)) {
    //    messagesVisited.add(coordinates);
    //  }
    //}
  }

  /**
   * @return the coordinates
   */
  public MyPoint getCoordinates() {
    return coordinates;
  }

  /**
   * @return the costDepth
   */
  public double getCost() {
    return cost;
  }

  /**
   * @return the action
   */
  public String getAction() {
    //if (parent == null)
    //  return "";
    return "";//parent.getAction() + action;
  }
  public void reveal() {
   mapLocation.setRevealed(true);
  }
  /**
   * @return the mapLocation
   */
  public Tile getMapLocation() {
    return mapLocation;
  }

  /**
   * @return the messagesVisited
   */
  //public TreeSet<MyPoint> getMessagesVisited() {
  //  return messagesVisited;
  //}

  /**
   * @return the parent
   */
  public SearchNode getParent() {
    return parent;
  }

  /**
   * 
   * @return If a message is found at this location
   */
  public boolean hasMessage() {
    return mapLocation.isMine();
  }

  /**
   * 
   * @return returns the Tile contained at this location.
   */
  public Tile getMapNode() {
    return mapLocation;
  }

  /**
   * 
   * @return the state of the search at this node.
   */
  public String getState() {
    return "";//messagesVisited.toString();
  }

  /*
   * (non-Javadoc)
   * 
   * @see java.lang.Object#hashCode()
   */
  @Override
    public int hashCode() {
    final int prime = 31;
    int result = 1;
    result = prime * result + ((coordinates == null) ? 0
      : coordinates.hashCode());
    result = prime * result + ((mapLocation == null) ? 0
      : mapLocation.hashCode());
    return result;
  }

  /*
   * (non-Javadoc)
   * 
   * @see java.lang.Object#equals(java.lang.Object)
   */
  @Override
    public boolean equals(Object obj) {
    if (this == obj)
      return true;
    if (obj == null)
      return false;
    if (!(obj instanceof SearchNode))
      return false;
    SearchNode other = (SearchNode) obj;
    if (coordinates == null) {
      if (other.coordinates != null)
        return false;
    } else if (!coordinates.equals(other.coordinates))
      return false;
    if (mapLocation == null) {
      if (other.mapLocation != null)
        return false;
    } else if (!mapLocation.equals(other.mapLocation))
      return false;
    //if (messagesVisited == null) {
    //  if (other.messagesVisited != null)
    //    return false;
    //} else if (!messagesVisited.equals(other.messagesVisited))
    //  return false;
    return true;
  }

  /*
   * (non-Javadoc)
   * 
   * @see java.lang.Comparable#compareTo(java.lang.Object)
   */
  @Override
    public int compareTo(SearchNode o) {
    double diff = this.cost - o.cost;
    if (diff != 0.0) {
      return diff > 0.0 ? 1 : -1;
    }
    return this.coordinates.compareTo(o.getCoordinates());
  }
  
  public boolean hasMineNeighbor() {
    return mapLocation.getSquareNum() != 0; 
  }
}
