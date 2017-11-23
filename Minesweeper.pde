// TODO Return the no first click loss functionality!!
// This program currently takes inputs for the number of rows, columns, and mines, and creates a board for minesweeper
import java.util.HashSet;
void setup() {
  Tile[][] myBoard=createBoard(10, 10, 20, 9, 9);
  printBoard(myBoard);
}

void draw() {
}

// Creates the minesweeper board
Tile[][] createBoard(int m, int n, int N, int clickX, int clickY) {
  Tile[][] board=new Tile[m][n];

  // Checks to make sure there aren't more mines than board locations
  if (N>m*n) {
    // Sets number mines to be 1 less than number of locations
    N=m*n-1;
  }
  HashSet<Integer> mineLocations = new HashSet();
  while (mineLocations.size() < N) {
    mineLocations.add(int(random(m*n)));
  }

  for (int i = 0; i < m; i++) {
    for (int j = 0; j < n; j++) {
      board[i][j] = new Tile(i, j, mineLocations.contains(i*m+j));
    }
  }
  // Add neighbors
  for (int i = 0; i < m; i++) {
    for (int j = 0; j < n; j++) {
      try {
        board[i][j].setNeighbor(Tile.NW_NEIGHBOR, board[i-1][j-1]);
      } 
      catch(Exception e) {
      }
      try {
        board[i][j].setNeighbor(Tile.NORTH_NEIGHBOR, board[i-1][j]);
      } 
      catch(Exception e) {
      }
      try {
        board[i][j].setNeighbor(Tile.NE_NEIGHBOR, board[i-1][j+1]);
      } 
      catch(Exception e) {
      }
      try {
        board[i][j].setNeighbor(Tile.EAST_NEIGHBOR, board[i][j+1]);
      } 
      catch(Exception e) {
      }
      try {
        board[i][j].setNeighbor(Tile.SE_NEIGHBOR, board[i+1][j+1]);
      } 
      catch(Exception e) {
      }
      try {
        board[i][j].setNeighbor(Tile.SOUTH_NEIGHBOR, board[i+1][j]);
      } 
      catch(Exception e) {
      }
      try {
        board[i][j].setNeighbor(Tile.SW_NEIGHBOR, board[i+1][j-1]);
      } 
      catch(Exception e) {
      }
      board[i][j].calculateSquareNum();
    }
  }
  return board;
}

// Prints the board to the console
void printBoard(Tile[][] board) {
  int m=board.length;
  int n=board[0].length;
  for (int i=0; i<m; i++) {
    print('\n');
    for (int j=0; j<n; j++) {
      print(board[i][j].getSquareNum(), ' ');
    }
  }
}

// Function to dig for a mine at the clicked location
int[][] digLocation(int[][] board, int clickX, int clickY) {
  // Checks if location is unflagged; CHANGE IF LOGIC
  if (board[clickX][clickY]==0) {
    // Insert code to set boolean value of click state to be clicked

    // Checks location to see if mine was clicked
    if (board[clickX][clickY]==-1) {
      // Ends game if mine was clicked you looozer
      print("Game over you loser");
    } else {
      // Recursively checks adjacent locations to see if click propogates
      int i_sum;
      int j_sum;
      int m=board.length;
      int n=board[0].length;
      for (int i_add=-1; i_add<2; i_add++) {
        for (int j_add=-1; j_add<2; j_add++) {
          i_sum=clickX+i_add;
          j_sum=clickY+j_add;
          // Check if adjacent location exists and is not adjacent to any mines
          if (i_sum>=0 && i_sum<m && j_sum>=0 && j_sum<n && board[i_sum][j_sum]==0) {
            // Recursively checks new location
            board=digLocation(board, i_sum, j_sum);
          }
        }
      }
    }
  }
  return board;
}

// Function to flag/deflag location
int[][] flagLocation(int[][] board, int clickX, int clickY) {
  // Insert code to flip boolean value of flag when class gets made
  return board;
}