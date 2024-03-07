// In this project the goal is to create a falling "sand" simulator, in short i aim for creating pixels in my draw method that will fall to the bottom of the "canvas"
// and interact with eachother to build up small sandy hills. To acomplish this i will begin by creating a 2D array to make a grid in the background that the pixels will interact with.
// The idea is for the grid to only have 0's in each zone and every pixel being a 1. by doing this we can tell the program to differentiate between 1's and 0's making interactions between
// the pixel's somewhat easy and understandable. we begin by creating the 2D array "grid"

int [][] grid (int colum, int row) {
  int [][] gridArray = new int [colum][row];

  //now we give row and colum the value of 0 using for loops.

  for (int i = 0; i < gridArray.length; i++) {
    for (int n = 0; n < gridArray[i].length; n++) {
      gridArray[i][n] = 0; //this line of code gives all squares in the grid of position i,n the value of 0 therefor making the entire grid full of 0's
    }
  }
  return gridArray;
}

// now we will begin maing the size of our grid squares, ass of now we have yet to define a size.

int [][] gridSquare;
int size = 5; //this will define the size of our grid (bigger numbers mean bigger "pixels")
int colum, row;
int theColor = (0);
int green = 255;
int blue = 255;

//now that we have made our 2D array and made a global variable for the size of our grid we need to make sure that our variables colum and row only exist within our 2D array. To do this we will use booleans.

boolean checkColum (int i) {
  return i >= 0 && i <= colum - 1;

  // i>=0 checks that i is not negative (aka outside the grid) and i< colum -1 checks that the row dont exceed the number of colums in our grid. we de the same in the belleow boolean.
}
boolean checkRow (int n) {
  return n >= 0 && n <= row - 1;
}

//now we come to our setup method were we will define the size of the window asswell as the size of the grid itself by using width and height.

void setup() {
  size (500, 500);
  colum = width/size;
  row = height/size;
  gridSquare = grid(colum, row);
}

//that was probobly the easiest part of this whole project. Now we can begin creating our mouseDragged method. we will use this to "spawn" our sand. (the reason use mouseDragged and not mousePressed
// is because using mousePressed would mean that our sand will only fall in one place until the cursor us moved but using mouseDragged we can "carpet bomb" the screen with sand making more uniqe hills.
// It also makes it less tedious to use the program.

void mouseDragged() {
  int mouseColum = floor(mouseX/size);
  int mouseRow = floor(mouseY/size);

  //the floor method is used to round down floats to the nearest int, we use this becasue we don't want to create pixels that exists between the squares in our grid. Basically we want to prevent pixels
  //from being created outside the grid of our 2D array.

  // we will now add the sand itslef to the program.

  int  sand = 5;
  int areaOfSand = floor(sand/size); //As the name sugests this line of code is used to determin the area of witch our sand will be added.
  for (int i = -areaOfSand; i <= areaOfSand; i++) {
    for (int n = -areaOfSand; n <= areaOfSand; n++) {

      //what we are doing is creating a random spawning area for our sand pixels. the bellow code says that in a roll from 0-75% (random automaticly goes form 0 (inclusive) to 1 (exclusive)) if a number is
      //bellow 0,75 it creates a pixel of sand inside our areaOfSand.

      if (random(1) < 0.75) {
        int colum = mouseColum + i;
        int row = mouseRow + n;
        if (checkColum(colum) && checkRow(row)) {
          gridSquare[colum][row] = theColor;
        }
      }
    }
  }
  //This little bit of code is only cosmetic it is made to change the color of the sand in bluescale so we will be able to get more "depth" in our sand hills and it looks kinda like waves.
  theColor += 1;
  if (theColor > 255) {
    theColor = 1;
  }
}

//now that we have added the sand it is time to use the draw method to actuallay draw it on the screen

void draw() {
  background(255);

if(blue > 255){
    blue = 1;
  }
  if (blue <= 0){
    blue = 255;
  }
  if(green > 255){
    green = 1;
  }
  if (green <= 0){
    green = 255;
  }

  //for (int i = 0; i < colum; i++) {: This line starts a for loop that iterates over the columns of our grid.
  //It initializes the loop variable "i" to 0 and continues looping as long as i is less than the variable colum. we are using this to make sure that we are drawing inside of our 2D gid (array).
  //Inside the outer loop, we starts another for loop that iterates over the rows of the grid. Just like the outer loop it initializes the loop variable n to 0
  //and continues looping as long as n is less than the row. This is agian made to make sure we are operating in our grid.

  for (int i = 0; i < colum; i++) {
    for (int n = 0; n < row; n++) {
      noStroke();
      if (gridSquare[i][n] > 0) {

        //this line checks if the values inside gridSquare are greater than 0 witch happens when mouseDragged is used with the theColor function
        //and will then use the fill comand when their value is 1 or greater.

        fill(gridSquare[i][n], green, blue);

        //Without the gridSquare[i][n] inside the fill funktion our colorchages would never happen sinze it counts the changes in the position inside the grid to change color.
        //The below initialization of int's are used to calculates the x and y-coordinates for drawing the shape. It multiplies the column nad row index "i" by our
        //variable size to determine the x and y-coordinates. Then it creates a squre using the x and y-coordinates and gives it the size of, well size.

        int x = i * size;
        int y = n * size;
        square(x, y, size);
      }
    }
  }


  // well now that we have made a simple version of windows paint its time to add gravity to our sand, to do this we need to make a new 2D array. we'll tak more about this later.

  int [][] newGrid = new int [colum][row];

  //since we want the sand to fall we need to check the grid to make sure it either is empty or there already is sand

  for (int i = 0; i < colum; i++) {
    for (int n = row-1; n >= 0; n--) {
      int statusOnGrid = gridSquare[i][n];

      //the bellow code is used to check for already existing sand

     if (statusOnGrid > 0) {
       int below;
       if (n == row-1) {
       below = 1;
       } else {
       below = gridSquare[i][n+1];
       }

        //We also need to randomize where the sand will go when i lands on other sand. we are futher down checking to make sure that the grid is 0 both below and to the sides for the sand.
       //that means when the sand lands atop other sand pixels it will go the the side but if we don't randomize it all the sand will go to one side.
       
        int sides = 1;
        if (random(1) < 0.5) {
          sides *= -1;
          
          //The code takes sides witch is 1 and randomizes it and if its les than 0.5 the sides vlaue wil change to -1, then it will run agian.
          
        }

         //now we will check below, lef and rigth of the sand.
         
        int below1 = -1; // we initialize below1 and 2 with -1 because we don't want them to have a value yet.
        int below2 = -1;
        if (checkColum(i + sides)) {
          below1 = (n == row-1) ? 1 : gridSquare[i + sides][n + 1]; // Set below1 to the square below it inside the grid.
        }
        if (checkColum(i - sides)) {
          below2 = (n == row-1) ? 1 : gridSquare[i - sides][n + 1]; // Like with below1 we set below2 to the square below it inside the grid.
        }
        
        //A little explenation is need when origrinally making this program i ran into problems with my pixels disapering instantly and after a lot of trobleshooting i decided to ask chat gbt for help
        //and it used the aboe code as shortcuts for if else statements the ? is wat is used. the code can be read as (condition) ? valueIfTrue : valueIfFalse. so in our exaple 1 is our true value
        //while gridSquare[i + sides][n + 1] is our false value.
        //Now comes the code that will make it all work the gravity part!!
        
        if (below == 0) {
          newGrid[i][n + 1] = statusOnGrid;
        } else if (below1 == 0) {
          newGrid[i + sides][n + 1] = statusOnGrid;
        } else if (below == 0) {
          newGrid[i - sides][n + 1] = statusOnGrid;
          // Stay put!
        } else {
          newGrid[i][n] = statusOnGrid;
        }
      }
    }
  }
  gridSquare = newGrid;
}
