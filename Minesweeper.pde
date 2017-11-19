// This program currently takes inputs for the number of rows, columns, and mines, and creates a board for minesweeper

void setup() {
  int[][] myBoard=createBoard(10, 10, 9, 9, 9);
  printBoard(myBoard);
}

void draw() {
}

// Creates the minesweeper board
int[][] createBoard(int m, int n, int N, int clickX, int clickY) {
  int[][] board=new int[m][n];

  // Checks to make sure there aren't more mines than board locations
  if (N>m*n) {
    // Sets number mines to be 1 less than number of locations
    N=m*n-1;
  }

  for (int k=0; k<N; k++) {
    // Generate random mine location
    int i=int(random(0, m));
    int j=int(random(0, n));

    // Checks to see if mine already exists at location, OR if location was the first location clicked so player can't lose on first click
    while (board[i][j]==-1 || (i==clickX && j==clickY)) {
      i=int(random(0, m));
      j=int(random(0, n));
    }

    // Creates mine at the random location
    board[i][j]=-1;
  }

  // Generates numbers of mine touched by each location
  int count=0;
  int i_sum, j_sum;
  // Loop through each location
  for (int i=0; i<m; i++) {
    for (int j=0; j<n; j++) {
      // Check if location does not have a mine
      count=0;
      if (board[i][j]==0) {
        // Loop through adjacent locations
        for (int i_add=-1; i_add<2; i_add++) {
          for (int j_add=-1; j_add<2; j_add++) {
            i_sum=i+i_add;
            j_sum=j+j_add;
            // Check if adjacent location exists and has a mine
            if (i_sum>=0 && i_sum<m && j_sum>=0 && j_sum<n && board[i_sum][j_sum]==-1) {
              // Add 1 to the total if there is a mine
              count++;
            }
          }
        }
        // Set number of mines for the location
        board[i][j]=count;
      }
    }
  }
  return board;
}

// Prints the board to the console
void printBoard(int[][] board) {
  int m=board.length;
  int n=board[0].length;
  for (int i=0; i<m; i++) {
    print('\n');
    for (int j=0; j<n; j++) {
      print(board[i][j], ' ');
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