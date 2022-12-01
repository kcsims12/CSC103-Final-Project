class FailScreen{

PImage background;
int startTime;
int currentTime;
int delayTime;
boolean delayTimerStarted;

FailScreen(){
  background = loadImage("failed_background.png");
  delayTime = 4000;
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
    p1.hP = 12;
    level1.complete = false;
    level2.complete = false;
  }
  
  }
  
 
}

}
