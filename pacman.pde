// temps de jeu
int temps = 0;
int tempsF = 0;
// direction dans laquelle va pacman
char direction;
boolean win;
boolean lost;
// nb de dots pour savoir quand le joueur a gagné
int nbDots;
// nb de vies du joueur
int nbVies;
// nb de points necessaires pour gagner une vie
int nbPtVieSupp = 1000;
// mange un super dot
boolean boosted;
int timer;
int superScore;
// pour le clignotement des super dots
int blinkTimer = 500;
color blink;
// plus haut score
int[] sortedScores;
int highScore;
float appearance = 0;
// apparition des bonus toutes les 10s avec 10s d'intervalles
int tBonus = 15000;

// position de base du bonus
float bonusX;
float bonusY;
int posX;
int posY;

// menu
boolean isMenu = false;
boolean showBestScores = false;
boolean showSavedLvl = false;
// timer pour enlever le menu quelques secondes et save le board pour les sauvegardes
String[] listeSauvegardes;

boolean animate = false;
float posPX;
float posPY;
float intervalle = CELL_SIZE/10.2;

void setup() {
  size(800, 800, P2D); 

  menu = new Menu();

  // données initiales du jeu
  nbDots = 1;
  nbVies = 2;

  // creation du board et du jeu dans sa globalité
  lines = loadStrings("./levels/level1.txt");
  highestScores = loadStrings("./data/scores.txt");
  board = new Board(lines, CELL_SIZE);
  game = new Game(board, pacman);
  // données de partie
  nbDots -= 1;

  f = createFont("data/emulogic.ttf", 16, true);
  win = false;
  println(intervalle);
  // images
  pacmanLeft = loadImage("data/img/pacLeft.png");
  pacmanRight = loadImage("data/img/pacRight.png");
  pacmanUp = loadImage("data/img/pacUp.png");
  pacmanDown = loadImage("data/img/pacDown.png");
  pacmanFull = loadImage("data/img/pacFull.png");

  pac1 = loadImage("data/img/1.png");
  pac2 = loadImage("data/img/2.png");
  pac3 = loadImage("data/img/3.png");
  pac4 = loadImage("data/img/4.png");
  pac5 = loadImage("data/img/5.png");
  pac6 = loadImage("data/img/6.png");
  pac7 = loadImage("data/img/7.png");
  pac8 = loadImage("data/img/8.png");
  pac9 = loadImage("data/img/9.png");
  pac10 = loadImage("data/img/10.png");
  pac11 = loadImage("data/img/11.png");


  red = loadImage("data/img/redDown.png");
  blue = loadImage("data/img/blueDown.png");
  orange = loadImage("data/img/orangeDown.png");
  pink = loadImage("data/img/pinkDown.png");

  cerise = loadImage("data/img/cerise.png");

  title = loadImage("data/img/title.png");

  // mange un super dot
  boosted = false;
  superScore = 200;
  
  // scores
  sortedScores = new int[0];
  for(int i=0; i<highestScores.length; i++){
    sortedScores = append(sortedScores, int(highestScores[i]));
  }
  sortedScores = reverse(sort(sortedScores));

  // pour le bonus
  bonusX = random(board.nbCellsX);
  bonusY = random(board.nbCellsY);
  posX = int(bonusX);
  posY = int(bonusY);

}

void draw() {
  if (millis() < 4000) {
    background(0, 0, 30);
    rectMode(CENTER);
    noStroke();
    fill(255);
    rect(width/2, height/2-25, 490, 200, 40);
    imageMode(CENTER);
    image(title, width/2+25, height/2-20);
    textFont(f, 12);
    fill(255);
    text("lou bell production", width/2, height/1.2);
  }
  else if (isMenu == true) {
    game.drawIt();
    menu.drawIt();
    direction = 'i';
  } else {
    if (boosted == false) {
      background(0, 0, 30);
    } else {
     background(30, 30, 80);
    }
    game.drawIt();
    redGhost.out = true;
    if (boosted == false) {
      superScore = 200;
      if(redGhost.cellX == pacman.cellX && redGhost.cellY == pacman.cellY){
        nbVies -= 1;
        if(nbVies >= 0){
          game.update();
        } else {
          redGhost.cellX = 11;
          redGhost.cellY = 9;
          board.cells[9][11] = TypeCell.GHOST;
          board.cells[pacman.cellY][pacman.cellX] = TypeCell.PACMAN;
          lost = true;
        }
      }
    } else {
      if(redGhost.cellX == pacman.cellX && redGhost.cellY == pacman.cellY){
        redGhost.cellX = 11;
        redGhost.cellY = 9;
        board.cells[9][11] = TypeCell.GHOST;
        board.cells[pacman.cellY][pacman.cellX] = TypeCell.PACMAN;
        scoreJoueur += superScore;
        superScore *= 2;
      }
    }
    // permet de gerer la vitesse de deplacement
    if(millis() - tempsF > 200 && win == false && lost == false){
      if (redGhost.out == true) {
        redGhost.move();
      }
      tempsF += 200;
    }
    
    
    if (millis() - temps > 170 && win == false && lost == false) {
      if(isMenu == false){
        pacman.lauchMove();
      }
      /* Pas encore fait de fantomes differents donc je mets q'un seul ghost meme sur le txt
       pour l'instant ATTENTION
       if(blueGhost.out == true){
       blueGhost.move();
       }
       if(orangeGhost.out == true){
       orangeGhost.move();
       }
       if(pinkGhost.out == true){
       pinkGhost.move();
       }
       */

      temps += 170;
    }
    
  }
}

void keyPressed() {
  if (keyPressed && isMenu == false && win == false && lost == false && millis() > 4000) {
    pacman.move();
  }
  if (isMenu == true && keyPressed) {
    menu.changeSelect();
  }
  if(isMenu == true && keyPressed && showSavedLvl == true){
    menu.changeSelectLvl();
  }
  if (isMenu == true && showBestScores == true && keyPressed && key == 27) {
    showBestScores = false;
    key = 0;
  }
  else if (isMenu == true && showSavedLvl == true && keyPressed && key == 27) {
    showSavedLvl = false;
    key = 0;
  } else if (isMenu == true && showBestScores == false && keyPressed && key == 27) {
    isMenu = false;
    key = 0;
  } else if (isMenu == false && keyPressed && key == 27) {
    isMenu = true;
    key = 0;
  }
  if(keyPressed && isMenu == true && showSavedLvl == true && key == 10){
    String[] level = split(listeSauvegardes[menu.selectedSave], " ");
    String[] a = loadStrings("./levels/"+level[0]+".txt");
    game.loadGame(a);
    scoreJoueur = int(level[1]);
    nbVies = int(level[2]);
    nbPtVieSupp = 1000;
  }
  else if (keyPressed && isMenu == true && key == 10) {
    switch(menu.selected) {
    case 1:
      game.newGame();
      isMenu = false;
      break;
    case 2:
      fill(255);
      noStroke();
      rect(width/1.5, height/2.2, 175, 55);
      noFill();
      text("save", width/1.5, height/2.2+5);
      game.saveGame();
      break;
    case 3:
      showSavedLvl = true;
      break;
    case 4:
      showBestScores = true;
      break;
    }
  }
}


void mousePressed() {
  if ((win == true || lost == true) && mousePressed && mouseButton == LEFT) {
    loop();
    game.newGame();
  }
}
