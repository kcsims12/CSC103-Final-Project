class Bullet{
  //vars
  int x;
  int y;
  int d;
  int speed;
  
  boolean shouldRemove;
  
  int left;
  int right;
  int top;
  int bottom;
  
  //constructor
  Bullet (int startingX, int startingY){
    x = startingX;
    y = startingY;
    
    d = 20;
    speed = 15;
    shouldRemove = false;
    
   
  }
  
  void render(){
    fill (255);
    circle(x,y,d);
  }
                   
  void move(){
    x += speed;
    
     left = x - d/2;
    right = x + d/2;
    top = y - d/2;
    bottom = y + d/2;
  }
  
  void checkRemove(){
    if (x>width){
      shouldRemove = true;
    }
    
  }
  
  void shootEnemy(Enemy anEnemy){
    //if the bullet collides with the enemy
    //then flag the enemy to be removed
    if (top <=anEnemy.bottom &&
        bottom >= anEnemy.top &&
        left <= anEnemy.right &&
        right >= anEnemy.left){
          shouldRemove = true;
          
          anEnemy.hP -= 1;
          if(anEnemy.hP <= 0){
            anEnemy.shouldRemove = true;
            glassBreak2Noise.play();
          }else{
            glassBreak1Noise.play();
          }
        }
    
  }
  
  
}
