class Player{
  //vars
  int x;
  int y;
  
  int w;
  int h;
  
  boolean isMovingLeft;
  boolean isMovingRight;
  boolean isMovingUp;
  boolean isMovingDown;
  
   int left;
  int right;
  int top;
  int bottom;
  
  PImage superHero;
  PImage plane;
  
  int speed;
  
  int hP;
  //constructor
  Player(int startingX, int startingY, int startingW, int startingH ){
    
    x = startingX;
    y = startingY;
    w = startingW;
    h = startingH;
    
     left = x - w/2;
    right = x + w/2;
    top = y - h/2;
    bottom = y + h/2;
    
    isMovingLeft = false;
    isMovingRight = false;
    
    speed = 10;
    
    hP = 14;
    
    superHero = loadImage("superhero1_100H.png");
    plane = loadImage("airplane1_150W.png");
  }
  
  
  //functions
  void render(){
    //rectMode (CENTER);
    //rect(x,y,w,h);
    imageMode(CENTER);
    
    if (currentLevel == 2){
    image(superHero,x,y);
    }
    
    if (currentLevel == 3){
    image(plane,x,y);
    }
    
  }
  void move(){
    
    if(isMovingLeft == true){
     if(x > w/2 + speed){
     x -=speed;
      }
    }
    
    if(isMovingRight == true){
    if(x < width - w/2 - speed){
      x +=speed;
    }
    }
    if(isMovingUp == true){
      if(y > h/2 + speed){
      y -= speed;
      }
    }
    if(isMovingDown == true){
       if(y < height - h/2 - speed){
      y += speed;
    }
    }
    
    left = x - w/2;
    right = x + w/2;
    top = y - h/2;
    bottom = y + h/2;
    
  }
  
  void damage(int _damageHP){
    hP -= _damageHP;
    if(hP <=0){
      //end game
      println ("dead");
      currentLevel = -1;
    }
  }
  
  
}
