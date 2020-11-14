boolean Lost;
boolean Won = false;
boolean game = false;
int rectWidth;
int rectHeight;
int[][] openCell =  new int [5][5];
int[][] mines =  new int [5][5];
PImage img;
int num=3; 

void setup() {
  size (500, 500); 
  img = loadImage("bomb.png");
  rectWidth  = width/5;
  rectHeight = height/5;
  textAlign(CENTER, CENTER);
  int i = 0;
  while (i<num) 
  {
    int x = (int)random(5);
    int y = (int)random(5);
    if (mines[x][y] == 0) 
    {
      mines[x][y] = 5;
      i++;
    }
  }
  hints();
}

void hints() 
{      
  for (int row = 0; row<5; row++) 
  { 
    for (int col= 0; col<5; col++)
    {
      if (mines[row][col] !=5)
      {
        int sum = 0;
        for (int r = row-1; r<= row+1; r++) 
        {
          for (int c = col-1; c<= col +1; c++) 
          {
            if (r>-1&&r<5 &&c>-1&&c<5) 
            {
              if (mines[r][c]==5) 
              {
                sum = sum+ 1;
              }
            }
          }
        }
        mines[row][col] = sum;
      }
    }


    for (int j = 0; j<mines.length; j++) 
    {
      printArray(mines[j]);
    }
  }
}

void draw()
{
  textSize(15);
  for (int i = 0; i<5; i++) 
  {                                           
    for (int j = 0; j<5; j++) 
    {
      Lost = checkMine(i,j);
      if (openCell[i][j] == -1) 
      {
        if(Lost==false)
        {
        fill(255,255,255);
        rect(i*rectWidth, j*rectHeight, rectWidth, rectHeight);
        fill(0);
        text(mines[i][j], i*rectWidth + rectWidth/2, j*rectHeight + rectHeight/2);
        }
        else if(Lost==true)
        {
        fill(255);
        rect(i*rectWidth, j*rectHeight, rectWidth, rectHeight);
        image(img, i*rectWidth+20, j*rectHeight+20);
        for(int a=0; a<60; a++)
        {
          for(int b=0;b<60;b++)
        {
          color c=get(i*rectWidth+20+a, j*rectHeight+20+b);
          if(red(c)==0) set(i*rectWidth+20+a, j*rectHeight+20+b, color(255,0,0));
        }
        }
        }
      } 
      else if (openCell[i][j] == 1) 
      {
        if(Lost==false){
        fill(200);
        rect(i*rectWidth, j*rectHeight, rectWidth, rectHeight);
        fill(255, 0, 0);                                                   
        text("-2", i*rectWidth + rectWidth/2, j*rectHeight + rectHeight/2);
        }
        else if(Lost==true){
          image(img, i*rectWidth+20, j*rectHeight+20);
        }
      } 
      else 
      {
        fill(200);
        rect(i*rectWidth, j*rectHeight, rectWidth, rectHeight);             
      }
    }
  }
  game = checkOver();
  if(game == true)
  {
    fill(0,0,255);
    textSize(30);
    text("Game Over!", width/2, height/2 + 30);
  }
}

void mousePressed() 
{
  int i = mouseX/rectWidth;                               
  int j = mouseY/rectHeight;
  if (Won == false)
  {
    if (mouseButton == LEFT) 
    {
      openCell[i][j] = -1;
      if (mines[i][j] == 0) 
      { 
        IntList X = new IntList(); 
        IntList Y = new IntList(); 
        X.append(i); 
        Y.append(j);
        while (X.size() > 0) 
        {
          int row = X.remove(0);
          int col = Y.remove(0);
          for (int r = row-1; r<= row+1; r++) 
          {
            for (int c = col-1; c<= col +1; c++) 
            {
              if (r>-1&&r<5 &&c>-1&&c<5) 
              {
                if (mines[r][c]==0 && openCell[r][c] == 0) 
                {
                  X.append(r);
                  Y.append(c);
                }
                openCell[r][c] = -1;
              }
            }
          }
        }
      }
    } 
    else if (mouseButton == RIGHT) 
    {        
      if (openCell[i][j] == 1) 
      { 
        openCell[i][j] = 0;
      } 
      else 
      {  
        openCell[i][j] = 1;
      }
    }
  }
}

boolean checkWin() 
{                                        
  for (int row = 0; row<5; row++)
  {
    for (int col= 0; col<5; col++) 
    {
      if (mines[row][col] == 5 && openCell[row][col] != 1) 
      {
        return false;
      }
    }
  }
  return true;
}

boolean checkMine(int row, int col) 
{                                        
  if (mines[row][col] == 5) 
  {
    return true;
  }
  return false;
}

boolean checkOver()
{
  int i=0;
  for (int row = 0; row<5; row++)
  {
    for (int col= 0; col<5; col++) 
    {
      if (mines[row][col] == 5 && openCell[row][col] != 0 ) 
      {
        i++;
      }
    }
  }
  if(i==3) return true;
  else return false;
}
