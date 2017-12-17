import java.io.File;
import java.util.*;

/**
 * 
 */

/**
 * @author Doug Blase
 *
 */
public static class Search {

  /**
   * @param args
   */


  /**
   * Performs Breadth-First Search
   */

  public static String performBFS(Tile[][] map, int x, int y) {
    ArrayDeque<SearchNode> frontier = new ArrayDeque<SearchNode>();
    HashSet<SearchNode> explored = new HashSet<SearchNode>();
    try {
      SearchNode home = new SearchNode(map[x][y], null);
      frontier.add(home);
      // If the frontier is empty, then we have searched everything we can
      while (!frontier.isEmpty()) {
        SearchNode current = frontier.remove();
        current.updateStatus();
        // We never want to go back to where we came from....
        explored.add(current);
        // If not explored in this state, and not about to be
        // explored (in frontier), then add to frontier.
        if (!current.hasMessage()) {
          current.reveal();
          if (!current.hasMineNeighbor()) {
            for (Tile node : current.getMapNode()
              .getNeighbors()) {
              SearchNode child = new SearchNode(node, current);
              if (!explored.contains(child)
                && !frontier.contains(child))
                frontier.add(child);
            }
          }
        }
      }
      return "DONE";
    }
    catch (Exception e) {
      e.printStackTrace();
      return "NO SOLUTION";
    }
  }

  /**
   * Builds the representation of the state of the search.
   * 
   * @param node
   *            The current node being looked at
   * @return The state of the search at the node.
   */

  private static String buildState(SearchNode node) {
    return node.getCoordinates().toString() + " "
      + node.getState();
  }
}