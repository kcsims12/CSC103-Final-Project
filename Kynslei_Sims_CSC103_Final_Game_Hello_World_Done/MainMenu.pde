class MainMenu{
boolean startGame = false;
Button startGameButton;
Button backStoryButton;
PImage background;


MainMenu(){
  
  startGame = false;
  
  startGameButton = new Button (1050, 215, 170,100, color (117, 100,255), "Start");
  backStoryButton = new Button (1050, 395, 170,100, color (117, 150,255), "BackStory");
  
  background = loadImage("mainMenu_background.png");
}

void render(){
  //background(42);
  background (background);
  
  //Invisible buttons. Only render to align with background
  //startGameButton.render();
  //backStoryButton.render();
  
  fill (255);
  textAlign(CENTER);
  textSize(40);
  //text ("Level 1: Use Mouse", width/2,600);
  //text ("Level 2: Use w,s, & spacebar", width/2,650);
  //text ("Level 3: Use a & d", width/2,700);
  
}





}
