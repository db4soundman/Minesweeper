// TODO Return the no first click loss functionality!!
// This program currently takes inputs for the number of rows, columns, and mines, and creates a board for minesweeper
import java.util.HashSet;
public static final int SQUARE_PIXELS = 34; //number of pixels in a square
public static final int MENU_HEIGHT = 34; //number of pixels in a square
public static int time; //time in seconds
public int time_initial=millis()/1000; //time in seconds
public int N_mines=0; //number of mines
public int N_flags=0; //number of flags
public int game_status=0; //-1=lose, 0=in progress, 1=win
Tile[][] myBoard;//=createBoard(15, 10, 15, 9, 9);
void setup() {
  size(100, 100);
  surface.setResizable(true);
  restartGame();
  drawBoard(myBoard);
}

void draw() {
  drawBoard(myBoard);
  time=millis()/1000-time_initial;
}

void mousePressed() {
  myBoard=clickTile(myBoard);
}

void restartGame() {
  N_flags=0;
  game_status=0;
  myBoard=createBoard(15, 10, 15, 9, 9);
  time_initial=millis()/1000;
}

Tile[][] clickTile(Tile[][] board) {
  int i, j;
  i=mouseY / SQUARE_PIXELS;
  j=mouseX / SQUARE_PIXELS;
  if (i<0 || i>N_mines-1 || j<0 || j>N_mines-1 ) {
    restartGame();
  } else {
    if (mouseButton==RIGHT) {
      if (board[i][j].isFlagged() && N_flags>0) {
        board[i][j].toggleFlagged();
        N_flags=N_flags-1;
      } else {
        if (N_flags<N_mines) {
          board[i][j].toggleFlagged();
          N_flags=N_flags+1;
        }
      }
    } else if (mouseButton==LEFT) {
      if (!board[i][j].isFlagged()) {
        myBoard = digLocation(myBoard, i, j);
        //board[i][j].setRevealed(true);
      }
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
  N_mines=N;
  N_flags=0;
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
      try {
        board[i][j].setNeighbor(Tile.WEST_NEIGHBOR, board[i][j-1]);
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
      print(board[i][j].getSquareNum() == -1 ? "M" : board[i][j].getSquareNum(), ' ');
    }
  }
}

// Draws the board on the graphics window
void drawBoard(Tile[][] board) {
  int m=board.length;
  int n=board[0].length;
  surface.setSize(n*SQUARE_PIXELS, m*SQUARE_PIXELS+MENU_HEIGHT);
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
  for (int i=0; i<m+1; i++) {
    strokeWeight(2);
    line(0, i*SQUARE_PIXELS, width, i*SQUARE_PIXELS);
  }
  // print vertical lines
  for (int j=0; j<n; j++) {
    line(j*SQUARE_PIXELS, 0, j*SQUARE_PIXELS, height-MENU_HEIGHT);
  }
  fill(255, 255, 255);
  rect(width/2, height-MENU_HEIGHT/2, width, MENU_HEIGHT);
  fill(0, 0, 0);
  String sL="Time: "+str(time);
  text(sL, width/4, height-MENU_HEIGHT/2);
  String sR="Mines: "+str(N_mines-N_flags);
  text(sR, width*3/4, height-MENU_HEIGHT/2);

  fill(255, 0, 255);
  if (game_status==-1) {
    text("Game over you loser.", width/2, height/2);
    restartGame();
  } else if (game_status==1) {
    text("Dat boi wins!!!!!", width/2, height/2);
    restartGame();
  }
}


// Function to dig for a mine at the clicked location
Tile[][] digLocation(Tile[][] board, int clickX, int clickY) {
  // Checks if location is unflagged
  if (!board[clickX][clickY].isFlagged()) {
    // Insert code to set boolean value of click state to be clicked

    // Checks location to see if mine was clicked
    if (board[clickX][clickY].isMine()) {
      // Ends game if mine was clicked you looozer
      game_status=-1;
    } else {
      Search.performBFS(board, clickX, clickY);
    }
  }
  return board;
}

// Function to flag/deflag location
Tile[][] flagLocation(Tile[][] board, int clickX, int clickY) {
  // Insert code to flip boolean value of flag when class gets made
  return board;
}