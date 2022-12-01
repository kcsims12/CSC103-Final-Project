//sound library
import processing.sound.*;


//global sound vars
SoundFile backgroundMusic;
SoundFile shootNoise;
SoundFile glassBreak1Noise;
SoundFile glassBreak2Noise;
SoundFile buttonBeepNoise;
SoundFile failNoise;
SoundFile level1BackgroundMusic;
SoundFile level2backgroundMusic;
SoundFile lightningCrash;
SoundFile rainBackground;
//declaring vars
Player p1;

int currentLevel = 0;
MainMenu mainMenu;
Level_1 level1;
Level_2 level2;
Level_3 level3;
FailScreen failScreen;
WinScreen winScreen;
BackStoryScreen backStoryScreen;

//Array lists
ArrayList<Bullet> bulletList;
ArrayList<Enemy> enemyList;

boolean shootingReady = true;
int currentTime;
int startTime;
int shootingDelay = 200;

void setup() {
  
  size(1200, 800);

  p1 = new Player(0+50, height/2, 50, 50);

  //initialize my vars
  level1 = new Level_1 ();
  level2 = new Level_2 ();
  level3 = new Level_3 ();
  mainMenu = new MainMenu();
  failScreen = new FailScreen();
  winScreen = new WinScreen();
   backStoryScreen = new BackStoryScreen();
  
  //backgroundMusic = new SoundFile (this, "soundscape.wav");
  shootNoise = new SoundFile (this, "shoot-bullet.wav");
  glassBreak1Noise = new SoundFile (this,"glassbreak1.wav");
  glassBreak2Noise = new SoundFile (this,"glassbreak2.wav");
  buttonBeepNoise = new SoundFile (this,"buttonBeeps.wav");
  failNoise = new SoundFile (this,"failSound.wav");
  
  level1BackgroundMusic = new SoundFile (this, "pattern background short.wav");
  level2backgroundMusic = new SoundFile (this, "level2MusicShort.wav");
  rainBackground = new SoundFile (this, "rain short.wav");
  
  lightningCrash = new SoundFile (this, "lightning_crash.wav");
  currentLevel = 0;
  startTime = millis();
}

void draw() {
  currentTime = millis();

 // Only Render Level that player is on
  
  if (currentLevel == -1) {
   failScreen.render();
  }
  if (currentLevel == 0) {
    mainMenu.render();
  }
  if (currentLevel == 1) {
    level1.render();
    if (level1.complete) {
      currentLevel = 2;
      level2.init();
    }
  }
  if (currentLevel == 2) {
    level2.render();
    renderStats();
    if (level2.complete) {
      currentLevel = 3;
      level3.init();
    }
  }
  if (currentLevel == 3) {
    level3.render();
    renderStats();
    if (level3.complete) {
      currentLevel = 4;
    }
  }
  if (currentLevel == 4) {
   winScreen.render();
  }
  if (currentLevel == 6) {
   backStoryScreen.render();
  }

  //prevent player from shooting too much. 
  if ( currentTime - startTime >= shootingDelay) {
    shootingReady = true;
    startTime = millis();
  }


}

void mousePressed() {
  
   if(currentLevel == 6){ //backstory
    currentLevel = 0;
  }
  
  if(currentLevel == 0){
  if (mainMenu.startGameButton.isInButton()) {
    currentLevel = 1;
    level1.init();
  }
    
  if (mainMenu.backStoryButton.isInButton()) {
    currentLevel = 6;
    
  }
  
  }
   
  
  if(currentLevel == 1){
    
    //wait on buttons to be ready to be pressed
    if (level1.readyForInput){
      
      // only allow 6 clicks. After 6 clicks we can check is colors match.
      if(level1.clickCount < 6){
        if( level1.redButton.isInButton() ){
          
          level1.clickCount++;    //keep track of clicks seperately from ArrayLists
          level1.clickLightList.add(new Light(0));
          buttonBeepNoise.play();
          println (level1.clickCount);
        }
        if( level1.yellowButton.isInButton() ){
          
           level1.clickCount++;
           
           level1.clickLightList.add(new Light(1));
           println (level1.clickCount);
           buttonBeepNoise.play();
        }
        if( level1.greenButton.isInButton() ){
          
           level1.clickCount++;
           level1.clickLightList.add(new Light(2));
           println (level1.clickCount);
           buttonBeepNoise.play();
        }
        if( level1.blueButton.isInButton() ){
         
           level1.clickCount++;
           level1.clickLightList.add(new Light(3));
           println (level1.clickCount);
           buttonBeepNoise.play();
        }
      }
    }
    
  }
}
void keyPressed() {
  
  
  if (currentLevel == 2) {

    if (key == 'w') {
      p1.isMovingUp = true;
    }
    if (key == 's') {
      p1.isMovingDown = true;
    }

    if (level2.state > -1) {

      if (key == ' ' && shootingReady) {
        bulletList.add( new Bullet(p1.x, p1.y) );
        shootNoise.play();
        shootingReady = false;
      }
    }
  }


  if (currentLevel == 3) {
    p1.isMovingUp = false;
    p1.isMovingDown = false; 
    
    if (key == 'a') {
      p1.isMovingLeft = true;
    }
    if (key == 'd') {
      p1.isMovingRight = true;
    }
  }
}


void keyReleased() {
  if (currentLevel == 2) {

    if (key == 'w') {
      p1.isMovingUp = false;
    }
    if (key == 's') {
      p1.isMovingDown = false;
    }
  }

  if (currentLevel == 3) {
    if (key == 'a') {
      p1.isMovingLeft = false;
    }
    if (key == 'd') {
      p1.isMovingRight = false;
    }
  }
}

void renderStats() {

  String tempString = "player hP: " + str(p1.hP);
  textAlign (RIGHT);
  textSize(30);
  fill(255);
  text(tempString, width - 50, 30);
}
