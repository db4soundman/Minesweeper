// TODO Return the no first click loss functionality!!
// This program currently takes inputs for the number of rows, columns, and mines, and creates a board for minesweeper
import java.util.HashSet;
public static final int SQUARE_PIXELS = 34; //number of pixels in a square
Tile[][] myBoard=createBoard(15, 10, 40, 9, 9);
void setup() {
  drawBoard(myBoard);
}

void draw() {
  //frame.setLocation(500,100); // sets the initial position of the screen
  drawBoard(myBoard);
}

void mousePressed() {
  myBoard=clickTile(myBoard);
}

Tile[][] clickTile(Tile[][] board) {
  int i, j;
  i=mouseY / SQUARE_PIXELS;
  j=mouseX / SQUARE_PIXELS;
  if (mouseButton==RIGHT) {
    board[i][j].toggleFlagged();
  } else if (mouseButton==LEFT) {
    if(!board[i][j].isFlagged()){
      board[i][j].setRevealed(true);
    }
  }
  return board;
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
  while (mineLocations.size () < N) {
    mineLocations.add(int(random(m*n)));
  }

  for (int i = 0; i < m; i++) {
    for (int j = 0; j < n; j++) {
      board[i][j] = new Tile(i, j, mineLocations.contains(i*n+j));
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

// Draws the board on the graphics window
void drawBoard(Tile[][] board) {
  int m=board.length;
  int n=board[0].length;
  size(n*SQUARE_PIXELS, m*SQUARE_PIXELS);
  background(120, 120, 120);
  textSize(16);
  textAlign(CENTER, CENTER);
  rectMode(CENTER);

  for (int i=0; i<m; i++) {
    for (int j=0; j<n; j++) {
      if (board[i][j].isRevealed()) { // draw clicked tile background
        fill(200, 200, 200);
        rect(j*SQUARE_PIXELS+SQUARE_PIXELS/2, i*SQUARE_PIXELS+SQUARE_PIXELS/2, SQUARE_PIXELS, SQUARE_PIXELS);

        if (board[i][j].isMine()) { // draws mines
          fill(150, 150, 150);
          strokeWeight(1);
          ellipse(j*SQUARE_PIXELS+SQUARE_PIXELS/2, i*SQUARE_PIXELS+SQUARE_PIXELS/2, SQUARE_PIXELS*7/10, SQUARE_PIXELS*7/10);
        } else if (board[i][j].getSquareNum()!=0) { // prints square number text
          fill(0, 0, 0);
          text(board[i][j].getSquareNum(), j*SQUARE_PIXELS+SQUARE_PIXELS/2, i*SQUARE_PIXELS+SQUARE_PIXELS/2);
        }
      } else if (board[i][j].isFlagged()) { // draws flags
        fill(255, 0, 0);
        strokeWeight(1);
        rect(j*SQUARE_PIXELS+SQUARE_PIXELS/2, i*SQUARE_PIXELS+SQUARE_PIXELS*4/10, SQUARE_PIXELS*7/10, SQUARE_PIXELS*4/10);
        line(j*SQUARE_PIXELS+SQUARE_PIXELS*3/20, i*SQUARE_PIXELS+SQUARE_PIXELS/2, j*SQUARE_PIXELS+SQUARE_PIXELS*3/20, i*SQUARE_PIXELS+SQUARE_PIXELS*5/6);
      }
    }
  }

  // print horizontal lines
  for (int i=0; i<m; i++) {
    strokeWeight(2);
    line(0, i*SQUARE_PIXELS, width, i*SQUARE_PIXELS);
  }
  // print vertical lines
  for (int j=0; j<n; j++) {
    line(j*SQUARE_PIXELS, 0, j*SQUARE_PIXELS, height);
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

