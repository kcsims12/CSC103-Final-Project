class Light{
  int _color;
  
  Light (int _initColor){
    _color = _initColor ; //making a number represent each color option
   
  }
  
  
  void render(int _posX){
     
    //based on the _color number selected from random, given a color
     switch (_color) {
    case 0: //red
    fill(255,0,0);
    
    break;
    case 1: //yellow
    fill(240,250,0);
    break;
    
    case 2: //green
    fill(0,255,0);
    break;
    
    case 3: //blue
    fill(0,0,255);
    break;
     }
    
     rect(_posX,240,40,100);
   
    
  }
  
  void init(){
    
    
    
  }
  
  
  
  
  
  
}
