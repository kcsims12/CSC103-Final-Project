class WinScreen{

PImage background;
int startTime;
int currentTime;
int delayTime;
boolean delayTimerStarted;

WinScreen(){
  background = loadImage("win_Background.png");
  delayTime = 8000;
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
