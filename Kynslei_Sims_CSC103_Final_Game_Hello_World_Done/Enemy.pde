class Enemy {
  int x;
  int y;
  int w;
  int h;
  int startingY;
  
  int left;
  int right;
  int top;
  int bottom;
  
  boolean shouldRemove;
  boolean active;
  
  int hP;
  int type;  //0 = beaker, 1 = flask, 2 = test tube
  int speed;
  int damageHP;
  
  PImage beaker1;
  PImage beaker1b;
  
  PImage flask1;
  PImage flask1b;
  
  PImage testTube1;
  PImage testTube1b;
  
  PImage cloud3;
  PImage cloud4;
  PImage cloud5;
  
  PImage cloud3b;
  PImage cloud4b;
  PImage cloud5b;
  
  Enemy (int startingX, int _startingY,  int _type, int _speed){
    x = startingX;
    y = _startingY;
    startingY = y;
    
    type = _type;
    
    //Change Enemy stats based on type.
    switch (type) {   //0 = beaker, 1 = flask, 2 = test tube, 3, small cloud, 4 = med clouds, 5 = large cloud
    case 0:
     hP = 2;
    speed = 3;
    w = 70;
    h = 100;
    damageHP = 2;
    break;
    
     case 1:
     hP = 2;
    speed = 5;
    w = 54;
    h = 80;
    damageHP = 2;
    break;
    
     case 2:
     hP = 2;
    speed = 4  ;
    w = 20;
    h = 60;
    damageHP = 2;
    break;
    
    case 3:
    hP = 1;
    speed = _speed;
    w = 120;
    h = 75;
    damageHP = 1;
    break;
    
    case 4:
    hP = 1;
    speed = _speed;
    w = 150;
    h = 109;
    damageHP = 1;
    break;
    
    case 5:
    hP = 1;
    speed = _speed;
    w = 200;
    h = 173;
    damageHP = 1;
    break;
   }
   
   beaker1 = loadImage("beaker_1_100H.png");
   beaker1b = loadImage("beaker_1_100H_Hit.png");
   
    flask1 = loadImage("flask_1_80H.png");
    flask1b = loadImage("flask_1_80H_Hit.png");
    
    testTube1 = loadImage("testTube_1_60H.png");
    testTube1b = loadImage("testTube_1_60H_Hit.png");
    
    cloud3 = loadImage("cloud3.png");
    cloud4 = loadImage("cloud4.png");
    cloud5 = loadImage("cloud5.png");
    //lightning cloud flashes
    cloud3b = loadImage("cloud3b.png");
    cloud4b = loadImage("cloud4b.png");
    cloud5b = loadImage("cloud5b.png");
    

    //update hitbox
    left = x - w/2;
    right = x + w/2;
    top = y - h/2;
    bottom = y + h/2;
    
    shouldRemove = false;
    active = false;
    
    
  }
  
  void render(){
    rectMode (CENTER);
    imageMode(CENTER);
    
    //types 0,1,2 = level 2 - 0 = beaker, 1 = flask, 2 = test tube
    //types 3,4,5 = level 3 - 3 = slow clouds 4 = medium 5 = fast
    
    
     switch (type) {   
    case 0:
    if (hP == 2){
      image(beaker1, x, y);
    }else{
      image(beaker1b, x, y);
    }
    break;
    
     case 1:
    if (hP == 2){
      image(flask1, x, y);
    }else{
      image(flask1b, x, y);
    }
    break;
    
     case 2: //test tubes
      if (hP == 2){
      image(testTube1, x, y);
    }else{
      image(testTube1b, x, y);
    }
    break;
    
     case 3: //slow clouds
      if (hP == 2){
      image(cloud3b, x, y);
      if (!lightningCrash.isPlaying()) {
           lightningCrash.play();//lightning crash
    }
      
    }else{
      image(cloud3, x, y);
    }
    break;
    
     case 4: //med clouds
      if (hP == 2){
        image(cloud4b, x, y); //lightning cloud flash
    }else{
      image(cloud4, x, y);
    }
    break;
    
     case 5: //fast clouds
      if (hP == 2){
        image(cloud5b, x, y); //lightning cloud flash
    }else{
      image(cloud5, x, y);
    }
    break;
   }
    
   
    active = true;
  }
  
  void move(){
    float a = 100;  //amplitude
    float p = 100;  //Period
    float offset; //y function offset
    
    //Move enemies in a pattern based on type in Level 2
     switch (type) {
    case 0:
     x -= speed;
      break;
      case 1:
     x -= speed;
     a = 100;  //amplitude
     p = 300;  //Period
     offset  =  4 * a/p * abs((((x-p/4)%p)+p)%p - p/2) - a;   //Triangle Wave function pattern
     y = startingY + int(offset);
     
      break;
      case 2:
     x -= speed;
     a = 200;  //amplitude
     p = 200;  //Period
     offset = (int)(sin(x*2*PI/p)*(a/2) + (a/2));    //Sine wave function pattern
     y = startingY + int(offset) - int(a/2);
      break;
      
       case 3:
     y += speed;
      break;
      
       case 4:
     y += speed;
      break;
      
       case 5:
     y += speed;
      break;
     } 
    
    left = x - w/2;
    right = x + w/2;
    top = y - h/2;
    bottom = y + h/2;
      
  
  if(currentLevel == 2){
  if (x < -5 ){
    shouldRemove = true;
    p1.damage(damageHP);
  }
  }
  
  }
  void didHitPlayer(Player aPlayer){
    //if the enemy collides with the player
    //then flag the player as hit
    if (top <=aPlayer.bottom &&
        bottom >= aPlayer.top &&
        left <= aPlayer.right &&
        right >= aPlayer.left){
          aPlayer.damage(damageHP);
          shouldRemove = true;
        }
  
  }
}
