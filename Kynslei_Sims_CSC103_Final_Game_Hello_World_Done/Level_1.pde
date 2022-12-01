class Level_1 {
  boolean complete;
  int state;
  int startTime;
  int currentTime;
  int interval;
  int testTubeCounter;
  
  int mouse_posX = 820;
  int mouse_posY = height-240;
  int mouse_Pos_offset = 0;
  int mouse_Pos_offset_inc = 6;
  
  PImage background;
  PImage mouse_arrow;
  
  int backgroundX;
  int backgroundY;
  int backgroundW;
  int backgroundH;
  int backgroundKeypadX;
  int backgroundKeypadY;
  int backgroundKeypadW;
  int backgroundKeypadH;

  Button redButton;
  Button yellowButton;
  Button greenButton;
  Button blueButton;
  
  int clickCount;
  int[] clickOrder = new int[6];
  boolean readyForInput ;
  
  ArrayList<Light> lightList;
  ArrayList<Light> clickLightList;
  int lightNum;
  int lightTimerInterval;
  int failBlinkCounter;

  Level_1() {
    
    complete = false;
  }
  
  void init(){
  state = -2;
  clickCount = 0;
  failBlinkCounter = 0;
  
  background = loadImage("Level 1 Background.png");

  //sound features

  shootNoise.amp(1.0);
  shootNoise.rate(1.0);
  interval = 3000;
  
  backgroundX = width/2;
  backgroundY = height/2;
  backgroundW = 1200;
  backgroundH = 800;
  
  backgroundKeypadX = 1100;
  backgroundKeypadY = 600;
  backgroundKeypadW = 2850;
  backgroundKeypadH = 1900;
  
  lightList = new ArrayList <Light>();
  clickLightList = new ArrayList <Light>();
  
  mouse_arrow = loadImage("mouse_arrow.png");
   
  redButton = new Button(590, 420, 100,100, color(255,0,0) ,"" );
  yellowButton = new Button(710, 420, 100,100, color(240,250,0) ,"" );
  greenButton = new Button(590, 530, 100,100, color(0,255,0) ,"" );
  blueButton = new Button(710, 530, 100,100, color(0,0,255) ,"" );
  
  readyForInput = false;
  lightTimerInterval = 5000;
  }

  void render() {
    imageMode(CENTER);   
    rectMode(CENTER);
    
    currentTime = millis();
  
 
    switch (state) {
    case -2: 
    image(background,backgroundX,backgroundY);
     if ( currentTime - startTime >= interval){ //check if amount of time has passed
    
       state = -1;
       interval = 4500;
       startTime = millis();
       }
       
      break;
      
      //Zoom in Image to focus on Keypad
    case -1: 
     
      if (backgroundX < backgroundKeypadX){
        backgroundX += 12;
      }
      if (backgroundY < backgroundKeypadY){
        backgroundY += 12;
      }
      if (backgroundW < backgroundKeypadW){
        backgroundW += 45;
      }
      if (backgroundH < backgroundKeypadH){
        backgroundH += 45;
      }
      
      image(background,backgroundX,backgroundY,backgroundW,backgroundH);
      
      
      if ( currentTime - startTime >= interval){
       
        backgroundX = backgroundKeypadX;
        backgroundY = backgroundKeypadY;
        backgroundW = backgroundKeypadW;
        backgroundH = backgroundKeypadH;
        
        image(background,backgroundX,backgroundY,backgroundW,backgroundH);
        
       state = 0;
       startTime = millis();
       interval = lightTimerInterval;
          
       }
       
      break;
      
      
     case 0: 
     
     //display and move mouse indicator back and forth
     mouse_Pos_offset += mouse_Pos_offset_inc;
    if(mouse_Pos_offset > 60){
      mouse_Pos_offset_inc = -mouse_Pos_offset_inc;
    }
    if(mouse_Pos_offset < -60){
      mouse_Pos_offset_inc = -mouse_Pos_offset_inc;
    }
    
    imageMode(CENTER);
    image(background,backgroundX,backgroundY,backgroundW,backgroundH);
    image(mouse_arrow ,mouse_posX + mouse_Pos_offset, mouse_posY );
    
     if ( currentTime - startTime >= interval){ //check if amount of time has passed
    
       state = 1;
       interval = 1500;
       startTime = millis();
       }
       
      break;  
    
    
     //Redraw Keypad
    case 1: 
     
      image(background,backgroundX,backgroundY,backgroundW,backgroundH);
           
      if ( currentTime - startTime >= interval){
       
       state = 2;
       startTime = millis();
       interval = lightTimerInterval;
       
       //makes light array
        for(int i = 0; i<6 ; i++){
       lightList.add( new Light(int(random(0,4))));
       
     }
       }
       
      break;
    
    case 2:   
    
     //draws lights
     lightNum = 0;
      for (Light aLight : lightList) {
       
        int posX = 532 + (lightNum*48);
        
        aLight.render(posX);
       
       lightNum++;
     }
     
      if ( currentTime - startTime >= interval){ 
    
       state = 3;
       }
       
    break;
    
    //draws background over lights
     case 3:   
     image(background,backgroundX,backgroundY,backgroundW,backgroundH);
     if ( currentTime - startTime >= interval){ 
     
       state = 4;
       }
    break;
    
    case 4:   
     //click corresponding buttons
     readyForInput = true;
     
     //draw lights as they are clicked
     lightNum = 0;
      for (Light aLight : clickLightList) {
       
        int posX = 532 + (lightNum*48);
        
        aLight.render(posX);
       
       lightNum++;
     }
     
     
     if (clickCount > 5){
      boolean colorMatched = true;
      lightNum = 0;
      
      //check if clicked lights match the random light array
      for (Light aLight : lightList) {
       if(aLight._color != clickLightList.get(lightNum)._color){
         colorMatched = false;
       }
       lightNum++;
     }
     if(colorMatched ){  //reset all vars for another pattern
     println ("good"); //winning
      startTime = millis();
      interval = 1000;
      lightNum = 0;
      lightList.clear();
      clickLightList.clear();
      clickCount = 0;
      lightTimerInterval -= 500; //gives less time to memorize
      
      //Have 3 phases of patterns based on time
      if(lightTimerInterval > 3500){
        
        state = 5; //sends to reset pattern
      }else{
        
        state = 10; //completed enough to go to next level
      }
     }
     else{
       println ("failed"); //losing
       state = 6;
       interval = 750;
       startTime = millis();
       failNoise.play();
     }
     }
     
     
    break;
    
    case 5:   
    //Reset lights & time for next phase of level 1 by going back through all steps
     if ( currentTime - startTime >= interval){ 
    
       state = 1;
       startTime = millis();
       }
    break;
    
    case 6:
    //delay
    if ( currentTime - startTime >= interval){ 
     
       state = 7;
       startTime = millis();
    }
    break;
    
     case 7:
     lightNum = 0;
     //flashes original pattern
      for (Light aLight : lightList) {
       
        int posX = 532 + (lightNum*48);
        
        aLight.render(posX);
       
       lightNum++;
     }
    if ( currentTime - startTime >= interval){ 
      
     state = 8;
     startTime = millis();
       
    }
    break;
    
    case 8:
     lightNum = 0;
     //flashes clicked pattern
      for (Light aLight : clickLightList) {
       
        int posX = 532 + (lightNum*48);
        
        aLight.render(posX);
       
       lightNum++;
     }
    if ( currentTime - startTime >= interval){ 
   
      //how many blinks until fail screen
     failBlinkCounter++;
     if (failBlinkCounter > 3){
       currentLevel = -1;
     }else{
       state = 6;
     }
       
    }
    break;
    
    case 10:   
     if ( currentTime - startTime >= interval){
       
     complete = true;
       
       }
    break;
    
    }
    
    //Draw buttons for debugging only. Buttons are invisble
    //redButton.render();
    //yellowButton.render();
    //greenButton.render();
    //blueButton.render();
    
    
    //makes background noise loop
   
  
  
    if (level1BackgroundMusic.isPlaying() == false && currentLevel == 1) {
      level1BackgroundMusic.play();
    }
  }
}
