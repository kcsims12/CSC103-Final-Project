class Button{
int x;
int y;
int w;
int h;
color c;
String text;
  
  Button(int _x, int _y, int _w,int _h, color _c, String _text){
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    
    c = _c;
    text = _text;
  }

void render(){
  rectMode(CENTER);
  fill (c);
  rect (x,y,w,h);
  
  fill (255);
  textAlign(CENTER);
  textSize(20);
  text (text, x,y);
}

boolean isBetween(int position, int min, int max){
  if (position >= min && position <= max){
    return true; //saying the thing is between the boundaries given later
    //as soon as the process hits return, it leaves the function looking for the call
  }
  else{
    return false;
  }
}


//will be used when we call each button
boolean isInButton(){
  rectMode(CENTER);
  //make hitbox variables
  int top = y - h/2;
  int bottom = y + h/2;
  int left = x - w/2;
  int right = x + w/2;
  
  //using the boolean function from earlier
  //made the position = mouse and min is left and max is right
  //this means it is in the box made and between the hitbox settings
  //if MouseX is between left and right AND if MouseY is between top and bottom
  
  if (isBetween(mouseX, left, right) && isBetween(mouseY, top, bottom)){
    return true;
  }
   else{
     return false;
   }
}
}
