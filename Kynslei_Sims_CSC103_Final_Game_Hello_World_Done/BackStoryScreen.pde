class BackStoryScreen{

PImage background;
int startTime;
int currentTime;
int delayTime;
boolean delayTimerStarted;

BackStoryScreen(){
  background = loadImage("backstory_background.png");
  delayTime = 30000;
  delayTimerStarted = false;
}

void render(){
 
  background (background);
  currentTime = millis();
  
  if (!delayTimerStarted){ 
    println("Reset Time");
    startTime = millis(); //reset startTime
    delayTimerStarted = true;
  }else{
  if (currentTime - startTime >= delayTime){
    delayTimerStarted = false; //reset timer Started for next time.
    currentLevel = 0;
  }
  
  }
  
 
}

}
