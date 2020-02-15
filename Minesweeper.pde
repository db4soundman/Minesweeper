// TODO: //<>// //<>//
// No loss on first click
// High score list as text file?
// Add difficulty modes
//
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
}

void draw() {
  drawBoard(myBoard);
  if (game_status==0) {
    time=millis()/1000-time_initial;
  }
}

void mousePressed() {
  int m, n, i, j;
  m=myBoard.length;
  n=myBoard[0].length;
  i=mouseY / SQUARE_PIXELS;
  j=mouseX / SQUARE_PIXELS;
  if (i>=0 && i<m && j>=0 && j<n) {
    if (game_status==0) {
      myBoard=clickTile(myBoard, i, j);
    }
  } else {
    if (mouseX>=width/2-0.5*SQUARE_PIXELS && mouseX<=width/2+0.5*SQUARE_PIXELS) {
      restartGame();
    }
  }
}

void restartGame() {
  N_flags=0;
  game_status=0;
  myBoard=createBoard(8, 8, 10);
  time_initial=millis()/1000;
}

Tile[][] clickTile(Tile[][] board, int i, int j) {

  if (mouseButton==RIGHT) {
    // Remove flag
    if (board[i][j].isFlagged() && N_flags>0) {
      board[i][j].toggleFlagged();
      N_flags=N_flags-1;
    } else {
      // Place flag
      if (N_flags<N_mines && !board[i][j].isRevealed()) {
        board[i][j].toggleFlagged();
        N_flags=N_flags+1;
      }
    }
  } else if (mouseButton==LEFT) {
    // Dig tile for mine
    if (!board[i][j].isFlagged()) {
      myBoard = digLocation(myBoard, i, j);
      //board[i][j].setRevealed(true);
    }
  }
  return board;
}

// Creates the minesweeper board
Tile[][] createBoard(int m, int n, int N) {
  if (n<5) {
    n=5;
  }
  if (m<2) {
    m=2;
  }
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
  background(160, 160, 160);
  textSize(16);
  textAlign(CENTER, CENTER);
  rectMode(CENTER);
  stroke(0, 0, 0);

  // Draw Menu
  fill(255, 255, 255);
  rect(width/2, height-MENU_HEIGHT/2, width, MENU_HEIGHT);
  fill(255, 255, 255);
  rect(width/2, height-MENU_HEIGHT/2, SQUARE_PIXELS, SQUARE_PIXELS);
  // Draw Face
  fill(255, 255, 0);
  ellipse(width/2, height-MENU_HEIGHT/2, 0.75*SQUARE_PIXELS, 0.75*SQUARE_PIXELS);

  // Ongoing Game
  for (int i=0; i<m; i++) {
    for (int j=0; j<n; j++) {


      if (board[i][j].isRevealed()) { // draw clicked tile background
        fill(200, 200, 200);
        rect(j*SQUARE_PIXELS+SQUARE_PIXELS/2, i*SQUARE_PIXELS+SQUARE_PIXELS/2, SQUARE_PIXELS, SQUARE_PIXELS);
        if (board[i][j].getSquareNum()!=0) { // prints square number text

          // Color numbers
          switch (board[i][j].getSquareNum()) {
          case 1:
            fill(0, 0, 255);
            break;
          case 2:
            fill(0, 150, 0);
            break;
          case 3:
            fill(255, 0, 0);
            break;
          case 4:
            fill(0, 0, 100);
            break;
          case 5:
            fill(100, 0, 0);
            break;
          case 6:
            fill(0, 255, 255);
            break;
          case 7:
            fill(0, 0, 0);
            break;
          case 8:
            fill(120, 120, 120);
            break;
          }

          text(board[i][j].getSquareNum(), j*SQUARE_PIXELS+SQUARE_PIXELS/2, i*SQUARE_PIXELS+SQUARE_PIXELS/2);
        }
      } else if (board[i][j].isFlagged()) { // draws flags
        fill(255, 0, 0);
        strokeWeight(1);
        stroke(0, 0, 0);
        rect(j*SQUARE_PIXELS+SQUARE_PIXELS/2, i*SQUARE_PIXELS+SQUARE_PIXELS*4/10, SQUARE_PIXELS*7/10, SQUARE_PIXELS*4/10);
        line(j*SQUARE_PIXELS+SQUARE_PIXELS*3/20, i*SQUARE_PIXELS+SQUARE_PIXELS/2, j*SQUARE_PIXELS+SQUARE_PIXELS*3/20, i*SQUARE_PIXELS+SQUARE_PIXELS*5/6);
      }

      if (game_status!=0) { // draws mines at end
        if (board[i][j].isMine()) {
          fill(100, 100, 100);
          stroke(0, 0, 0);
          line(j*SQUARE_PIXELS+0.5*SQUARE_PIXELS, i*SQUARE_PIXELS+0.1*SQUARE_PIXELS, j*SQUARE_PIXELS+0.5*SQUARE_PIXELS, i*SQUARE_PIXELS+0.9*SQUARE_PIXELS);
          line(j*SQUARE_PIXELS+0.1*SQUARE_PIXELS, i*SQUARE_PIXELS+0.5*SQUARE_PIXELS, j*SQUARE_PIXELS+0.9*SQUARE_PIXELS, i*SQUARE_PIXELS+0.5*SQUARE_PIXELS);
          line(j*SQUARE_PIXELS+0.22*SQUARE_PIXELS, i*SQUARE_PIXELS+0.22*SQUARE_PIXELS, j*SQUARE_PIXELS+0.78*SQUARE_PIXELS, i*SQUARE_PIXELS+0.78*SQUARE_PIXELS);
          line(j*SQUARE_PIXELS+0.22*SQUARE_PIXELS, i*SQUARE_PIXELS+0.78*SQUARE_PIXELS, j*SQUARE_PIXELS+0.78*SQUARE_PIXELS, i*SQUARE_PIXELS+0.22*SQUARE_PIXELS);
          strokeWeight(1);
          ellipse(j*SQUARE_PIXELS+SQUARE_PIXELS/2, i*SQUARE_PIXELS+SQUARE_PIXELS/2, 0.6*SQUARE_PIXELS, 0.6*SQUARE_PIXELS);
        }
        if (board[i][j].isFlagged()) { // draw flags at end
          if (board[i][j].isMine()) {
            fill(255, 0, 0);
            strokeWeight(1);
            stroke(0, 0, 0);
            rect(j*SQUARE_PIXELS+SQUARE_PIXELS/2, i*SQUARE_PIXELS+SQUARE_PIXELS*4/10, SQUARE_PIXELS*7/10, SQUARE_PIXELS*4/10);
            line(j*SQUARE_PIXELS+SQUARE_PIXELS*3/20, i*SQUARE_PIXELS+SQUARE_PIXELS/2, j*SQUARE_PIXELS+SQUARE_PIXELS*3/20, i*SQUARE_PIXELS+SQUARE_PIXELS*5/6);
          } else {
            stroke(255, 0, 0);
            line(j*SQUARE_PIXELS+0*SQUARE_PIXELS, i*SQUARE_PIXELS+0*SQUARE_PIXELS, j*SQUARE_PIXELS+1*SQUARE_PIXELS, i*SQUARE_PIXELS+1*SQUARE_PIXELS);
            line(j*SQUARE_PIXELS+0*SQUARE_PIXELS, i*SQUARE_PIXELS+1*SQUARE_PIXELS, j*SQUARE_PIXELS+1*SQUARE_PIXELS, i*SQUARE_PIXELS+0*SQUARE_PIXELS);
          }
        }
      } else {
        // Draw Facial Features
        fill(0, 0, 0);
        strokeWeight(1);
        ellipse(width/2+0.1*SQUARE_PIXELS, height-MENU_HEIGHT/2-0.1*SQUARE_PIXELS, 0.05*SQUARE_PIXELS, 0.05*SQUARE_PIXELS);
        ellipse(width/2-0.1*SQUARE_PIXELS, height-MENU_HEIGHT/2-0.1*SQUARE_PIXELS, 0.05*SQUARE_PIXELS, 0.05*SQUARE_PIXELS);
        noFill();
        arc(width/2, height-MENU_HEIGHT/2-0.05*SQUARE_PIXELS, 0.5*SQUARE_PIXELS, 0.5*SQUARE_PIXELS, 0.65, PI-0.65);
      }
    }
  }


  // print horizontal lines
  for (int i=0; i<m+1; i++) {
    strokeWeight(2);
    stroke(0, 0, 0);
    line(0, i*SQUARE_PIXELS, width, i*SQUARE_PIXELS);
  }
  // print vertical lines
  for (int j=0; j<n; j++) {
    line(j*SQUARE_PIXELS, 0, j*SQUARE_PIXELS, height-MENU_HEIGHT);
  }

  fill(0, 0, 0);

  // Time
  String sL="T: " + str(time);
  text(sL, SQUARE_PIXELS, height-MENU_HEIGHT/2);

  // Mines Flagged
  String sR="M: " + str(N_mines-N_flags);
  text(sR, width-SQUARE_PIXELS, height-MENU_HEIGHT/2);


  //} else {


  // Lost Game
  if (game_status==-1) {

    // Draw Facial Features
    fill(0, 0, 0);
    strokeWeight(1);
    ellipse(width/2+0.1*SQUARE_PIXELS, height-MENU_HEIGHT/2-0.1*SQUARE_PIXELS, 0.05*SQUARE_PIXELS, 0.05*SQUARE_PIXELS);
    ellipse(width/2-0.1*SQUARE_PIXELS, height-MENU_HEIGHT/2-0.1*SQUARE_PIXELS, 0.05*SQUARE_PIXELS, 0.05*SQUARE_PIXELS);
    noFill();
    arc(width/2, height-0.2*SQUARE_PIXELS, 0.5*SQUARE_PIXELS, 0.5*SQUARE_PIXELS, 0.65+PI, PI-0.65+PI);

    // Won Game
  } else if (game_status==1) {

    // Draw Facial Features
    fill(0, 0, 0);
    strokeWeight(1);
    ellipse(width/2+0.15*SQUARE_PIXELS, height-MENU_HEIGHT/2-0.1*SQUARE_PIXELS, 0.2*SQUARE_PIXELS, 0.2*SQUARE_PIXELS);
    ellipse(width/2-0.15*SQUARE_PIXELS, height-MENU_HEIGHT/2-0.1*SQUARE_PIXELS, 0.2*SQUARE_PIXELS, 0.2*SQUARE_PIXELS);
    line(width/2+0.3*SQUARE_PIXELS, height-0.7*MENU_HEIGHT, width/2-0.3*SQUARE_PIXELS, height-0.7*MENU_HEIGHT);
    noFill();
    arc(width/2, height-MENU_HEIGHT/2-0.05*SQUARE_PIXELS, 0.5*SQUARE_PIXELS, 0.5*SQUARE_PIXELS, 0.65, PI-0.65);
  }
  //}
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

      // Check if all mines are cleared
      int m=board.length;
      int n=board[0].length;
      int totalRevealed = 0;
      for (int i=0; i<m; i++) {
        for (int j=0; j<n; j++) {
          if (board[i][j].isRevealed()) {
            totalRevealed++;
          }
        }
      }
      // Ends game is user wins
      if (m*n==totalRevealed+N_mines) {
        game_status=1;
      }
    }
  }
  return board;
}

// Function to flag/deflag location
Tile[][] flagLocation(Tile[][] board, int clickX, int clickY) {
  // Insert code to flip boolean value of flag when class gets made
  return board;
}
