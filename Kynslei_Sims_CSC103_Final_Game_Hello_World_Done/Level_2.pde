class Level_2 {
  boolean complete;
  int state;
  int enemiesSpawned;
  int startTime;
  int currentTime;
  int interval;
  int testTubeCounter;
  
  int key_W_posX = 50;
  int key_W_posY = height/2 - 200;
  int key_S_posX = 50;
  int key_S_posY = height/2 + 200;
  int key_Spc_posX = 350;
  int key_Spc_posY = height/2;
  int key_Pos_offset = 0;
  int key_Pos_offset_inc = 1;
  
  PImage background;
  PImage key_W;
  PImage key_S;
  PImage key_Spc;

  Level_2() {
    
    complete = false;
  }
  
  void init(){
  state = 0;
  
  background = loadImage("Level 2 Background.png");

  //sound features
  shootNoise.amp(1.0);
  shootNoise.rate(1.0);

  //making an array list
  bulletList = new ArrayList <Bullet>();
  enemyList = new ArrayList <Enemy>();
  
  key_W = loadImage("key_W.png");
  key_S = loadImage("key_S.png");
  key_Spc = loadImage("key_Spc.png");

  startTime = millis(); //declare in setup
  interval = 5000;
  testTubeCounter = 0;
  }

 void render() {
    //draw background
    background (background);
    
      
    currentTime = millis();
 
    //makes background noise loop
    if (level2backgroundMusic.isPlaying() == false && currentLevel == 2) {
      level2backgroundMusic.play();
    }

 switch (state) {
    case 0: //animation
    
      key_Pos_offset += key_Pos_offset_inc;
    if(key_Pos_offset > 20){
      key_Pos_offset_inc = -key_Pos_offset_inc;
    }
    if(key_Pos_offset < -20){
      key_Pos_offset_inc = -key_Pos_offset_inc;
    }
    
    imageMode(CENTER);
    image(key_W,key_W_posX , key_W_posY - key_Pos_offset);
    image(key_S,key_S_posX , key_S_posY + key_Pos_offset);
    image(key_Spc,key_Spc_posX + key_Pos_offset, key_Spc_posY );   
    
     if ( currentTime - startTime >= interval){ 
       state = 1;
       startTime = millis();
       interval = 1500;
       }
      break;
    case 1: //beakers
      
      if ( currentTime - startTime >= interval){ 
       enemySpawn(0); //spawn another beaker
       }
      if (enemiesSpawned >=10){ //have to spawn 10 beakers
        state = 2;
        enemiesSpawned = 0;
        startTime = millis();
      }
        
      break;
    case 2: //flasks
    if ( currentTime - startTime >= interval){ 
       enemySpawn(1); //spawn another flask
       }
      if (enemiesSpawned >=12){ //have to spawn  12 flasks
        state =3;
        enemiesSpawned = 0;
        interval = 4000;
        startTime = millis();
      }

    break;
    
    case 3: //delay between flasks and test tubes
    if ( currentTime - startTime >= interval){ 
      
        state = 4;
        interval = 400;  //Interval delay for Test Tubes
        startTime = millis();
      }

    break;
    
    
    case 4: //test tubes
      if ( currentTime - startTime >= interval){ 
      testTubeCounter++;
      if(testTubeCounter < 7){ //makes groups of 6
               enemySpawn(2); //spawn another flask
      }
      if(testTubeCounter > 200){ //doesn't reset spawn until after 200 frames (basically a timer)
               testTubeCounter = 0;
      }
       }
      if (enemiesSpawned >=18){ //complete after 18 Test Tubes spawned
        state = 5;
        interval = 6000;
        startTime = millis();
      }

      break;
      
    case 5:
      if ( currentTime - startTime >= interval){
        state = 6;
      }
    
   
    break;
    
     case 6:
    complete = true;
    
    //win
    break;
    
 }
      
      
    //player functions called
    p1.render();
    p1.move();

    //actions for each enemy
    for (Enemy anEnemy : enemyList) {
      anEnemy.move();
      anEnemy.render();
      anEnemy.didHitPlayer(p1);
    }


    //bullet for loop
    //actions for each bullet
    for (Bullet aBullet : bulletList) {
      aBullet.render();
      aBullet.move();
      aBullet.checkRemove();

      //connects enemy and bullet
      for (Enemy anEnemy : enemyList) {
        aBullet.shootEnemy(anEnemy);
      }
    }

    //for loop to remove unwanted bullets
    for (int i = bulletList.size()-1; i >= 0; i=i-1) {
      Bullet aBullet = bulletList.get(i);

      if (aBullet.shouldRemove == true) {
        bulletList.remove(aBullet);
      }
    }

    //for loop to remove unwanted enemies
    for (int i = enemyList.size()-1; i >= 0; i=i-1) {
      Enemy anEnemy = enemyList.get(i);

      if (anEnemy.shouldRemove == true) {
        enemyList.remove(anEnemy);
        
      }
    }
  }
  //determine where on y axis they can spawn
  void enemySpawn(int _type){
     int offset = 0;
     switch (_type){
       case 0:
       offset = 30;
       break;
         case 1:
       offset = 100;
       break;
         case 2:
       offset = 200;
       break;
       
       
     }
    //need to reset the timer
    startTime = millis();  //makes the startTime equal to the currentTime and restart counting, does not reset it back to 0
    enemyList.add( new Enemy(width + 10, int(random(offset, height-offset)) ,  _type, 1)); //add beaker to enemyList
    enemiesSpawned++;
    }
    
  }


//
