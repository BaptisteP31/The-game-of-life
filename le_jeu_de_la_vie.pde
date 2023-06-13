int SIZE = 600;
int DIV = 30;
boolean [][] array = new boolean[DIV][DIV];

void setup() {
  size(600, 600);
  background(255);
  strokeWeight(.1);
  
  // Initialise MATRIX
  for(int i=0; i<DIV; i++)
  {
   for(int j=0; j<DIV; j++)
   {
     array[i][j] = (int(random(8)) == 1);

   }
  }
  
  int gridSize = SIZE / DIV;
  for (int i = 0; i <= DIV; i++) {
    int x = i * gridSize; 
    line(x, 0, x, SIZE);
  }
  
  // Dessine les lignes horizontales
  for (int j = 0; j <= DIV; j++) {
    int y = j * gridSize;  
    line(0, y, SIZE, y);
  }
  
  //noLoop();
}

void displayGrid()
{
  for(int i=0; i<DIV; i++)
  {
   for(int j=0; j<DIV; j++)
   {
     if(array[i][j] == true)
     {
       fill(0);
       square(i*(SIZE/DIV), j*(SIZE/DIV), SIZE/DIV);
     }
     else
     {
       fill(255);
       square(i*(SIZE/DIV), j*(SIZE/DIV), SIZE/DIV);
     }
   }
  }
}

int countNeighbors(int x, int y) {
  int count = 0;
  
  for (int i = -1; i <= 1; i++) {
    for (int j = -1; j <= 1; j++) {
      int neighborX = (x + i + DIV) % DIV;  // Gestion des bords toriques
      int neighborY = (y + j + DIV) % DIV;  // Gestion des bords toriques
      
      if (!(i == 0 && j == 0) && array[neighborX][neighborY]) {
        count++;
      }
    }
  }
  
  return count;
}

void updateGrid()
{
   boolean[][] nextGeneration = new boolean[DIV][DIV]; 
   
   for (int i = 0; i < DIV; i++) {
    for (int j = 0; j < DIV; j++) {
      int neighbors = countNeighbors(i, j);  // Compte le nombre de voisins
      
      // Règles du jeu de la vie
      if (array[i][j] && (neighbors < 2 || neighbors > 3)) {
        nextGeneration[i][j] = false;     // Cellule vivante meurt
      } else if (!array[i][j] && neighbors == 3) {
        nextGeneration[i][j] = true;      // Cellule morte devient vivante
      } else {
        nextGeneration[i][j] = array[i][j];  // Maintient l'état actuel de la cellule
      }
    }
  }
  
  array = nextGeneration;
}

void draw() {
  //println("loop");
  displayGrid();
}

void mouseClicked()
{
   println("Clicked: {" + mouseX + ";" + mouseY + "}" ); 
   println("Changing state for {" + mouseX/(SIZE/DIV) + ";" + mouseY/(SIZE/DIV) + "}");
   array[mouseX/(SIZE/DIV)][mouseY/(SIZE/DIV)] = !array[mouseX/(SIZE/DIV)][mouseY/(SIZE/DIV)];
}

void keyPressed()
{
 //println(keyCode); 
 
 // SpaceBar
 if(keyCode == 32)
 {
   updateGrid();
 }
}
