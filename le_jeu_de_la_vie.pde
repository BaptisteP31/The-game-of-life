int SIZE = 800;
int DIV = 40;
int gen = 0;
boolean running = false; 
boolean [][] array = new boolean[DIV][DIV];

void setup() {
  size(800, 800);
  background(255);
  stroke(200);
  strokeWeight(1.5);
  
  randomArray();
  
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
  displayGrid();
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

void randomArray()
{
 for(int i=0; i<DIV; i++)
  {
   for(int j=0; j<DIV; j++)
   {
     array[i][j] = (int(random(8)) == 1);
   }
  }
}


int countNeighbors(int x, int y) {
  int count = 0;
  
  // Parcourir les voisins de la cellule
  for (int i = -1; i <= 1; i++) {
    for (int j = -1; j <= 1; j++) {
      if (i == 0 && j == 0) {
        continue;  // Ignorer la cellule elle-même
      }
      
      int neighborX = x + i;
      int neighborY = y + j;
      
      // Vérifier si le voisin est dans les limites de la grille
      if (neighborX >= 0 && neighborX < DIV && neighborY >= 0 && neighborY < DIV) {
        if (array[neighborX][neighborY]) {
          count++;
        }
      }
    }
  }
  
  return count;
}

void updateGrid()
{
   surface.setTitle("Running on gen " + gen);
   gen++;
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
  if(running)
  {
    updateGrid();
    displayGrid();
    delay(100);
  }
}

void mouseClicked()
{
   println("Clicked: {" + mouseX + ";" + mouseY + "}" ); 
   println("Changing state for {" + mouseX/(SIZE/DIV) + ";" + mouseY/(SIZE/DIV) + "}");
   array[mouseX/(SIZE/DIV)][mouseY/(SIZE/DIV)] = !array[mouseX/(SIZE/DIV)][mouseY/(SIZE/DIV)];
   displayGrid();
}

void keyPressed()
{
 println(keyCode); 
 
 switch(keyCode)
 {
   case 32: // space bar
     running = !running;
     if(!running)
       surface.setTitle("Stopped on gen " + gen);
     break;
      
   case 127: // delete key
     gen = 0;
     surface.setTitle("Stopped on gen " + gen);
     array = new boolean[DIV][DIV];
     displayGrid();
     break;
     
   case 36: // start key
     gen = 0;
     surface.setTitle("Stopped on gen " + gen);
     array = new boolean[DIV][DIV];
     randomArray();
     displayGrid();
     break;
 }
}
