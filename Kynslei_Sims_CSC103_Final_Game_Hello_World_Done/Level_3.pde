class Level_3 {
 boolean complete;
  int state;
  int enemiesSpawned;
  int startTime;
  int currentTime;
  int interval;
  int cloudLigntningChance;
  int cloudSpeed;
  int key_A_posX = 400;
  int key_A_posY = 750;
  int key_D_posX = width-400;
  int key_D_posY = 750;
  int key_PosX_offset = 0;
  int key_PosX_offset_inc = 1;
  
  PImage background;
  PImage key_A;
  PImage key_D;

  Level_3() {
    
    complete = false;
  }
  
  void init(){
  state = 0;
  p1.x = width/2;
  p1.y = height - p1.h/2 - 30;
  cloudLigntningChance = 0;

 //sound features
  
  shootNoise.amp(1.0);
  shootNoise.rate(1.0);

  //making an array list (clouds)
  enemyList = new ArrayList <Enemy>();
  key_A = loadImage("key_A.png");
  key_D = loadImage("key_D.png");

startTime = millis(); //declare in setup
  interval = 5000;
  }

 void render() {
    //draw background
   background (52,40,160); //blue sky
    
    currentTime = millis();
  
     
    //makes background noise loop
    if (rainBackground.isPlaying() == false) {
      rainBackground.play();
    }
    
 //timer if statement
 switch (state) {
    case 0: //animation
    key_PosX_offset += key_PosX_offset_inc;
    if(key_PosX_offset > 20){
      key_PosX_offset_inc = -key_PosX_offset_inc;
    }
    if(key_PosX_offset < -20){
      key_PosX_offset_inc = -key_PosX_offset_inc;
    }
    
    imageMode(CENTER);
    image(key_A,key_A_posX - key_PosX_offset,key_A_posY);
    image(key_D,key_D_posX + key_PosX_offset, key_D_posY);
     if ( currentTime - startTime >= interval){ //want greater than and equal to in case the time does not land on a certain second
       state = 1;
       interval = int(random(1200,1600));
       println ("Start Phase 1");
       }
      break;
    case 1: //slow
      cloudSpeed = 8;
      if ( currentTime - startTime >= interval){ //want greater than and equal to in case the time does not land on a certain second
       enemySpawn(3); //spawn slow clouds
       }
      if (enemiesSpawned >=30){ //have to dodge 15 clouds
        state =2;
        enemiesSpawned = 0;
        println ("Start Phase 2");
      }
        
      break;
    case 2: //med
    cloudSpeed = 11;
    
    if ( currentTime - startTime >= interval){ //want greater than and equal to in case the time does not land on a certain second
       enemySpawn(4); //spawn another flask
       }
      if (enemiesSpawned >=40){ //have to dodge 15 clouds
        state =3;
        enemiesSpawned = 0;
        println ("Start Phase 3");
      }

    break;
    case 3: //fast
    cloudSpeed = 13;
    
      if ( currentTime - startTime >= interval){ //want greater than and equal to in case the time does not land on a certain second
         enemySpawn(5); //spawn another flask
      }
     
      if (enemiesSpawned >=50){ //dodge 15 clouds
        state = 4;
        interval = 3000;
        startTime = millis();
      }

      break;
      
    case 4: //win
    
    rainBackground.stop();
    if ( currentTime - startTime >= interval){ //want greater than and equal to in case the time does not land on a certain second
         complete = true;
    println ("You Win");
    
      }
    break;
 }
      
      
    //player functions called
    p1.render();
    p1.move();

    //actions for each enemy
    for (Enemy anEnemy : enemyList) {
      //flashing animation between normal and lightning, hP used as changing var
      //regular cloud 
      anEnemy.hP = 1;
      //lightning cloud flash
      cloudLigntningChance = int(random(0,60));
      if(cloudLigntningChance == 50){
        anEnemy.hP = 2;
        //background (60,50,160); //blue sky
        }
      anEnemy.move();
      anEnemy.render();
      anEnemy.didHitPlayer(p1);
    }


    //for loop to remove unwanted enemies
    for (int i = enemyList.size()-1; i >= 0; i=i-1) {
      Enemy anEnemy = enemyList.get(i);

      if (anEnemy.shouldRemove == true) {
        enemyList.remove(anEnemy);
        enemiesSpawned++;
      }
    }
  }
  //speed given
  void enemySpawn(int _type){
     enemiesSpawned++;
    //need to reset the timer
    startTime = millis();  //makes the startTime equal to the currentTime and restart counting, does not reset it back to 0
    enemyList.add( new Enemy(int(random(125, width-125)), -100 , int(random(3,6)), cloudSpeed)); //add beaker to enemyList
    interval = int(random(180,500));
    //print ("Interval: ");println(interval);
    }
    
  }
