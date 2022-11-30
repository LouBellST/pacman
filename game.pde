class Game {
  Board board;
  Hero hero;

  String _levelName;

  Game() {
    board = null;
    hero = null;
  }

  Game(Board _board, Hero _hero) {
    board = _board;
    hero = _hero;
    scoreJoueur = 0;
  }

  void loadGame(String[] toConvert) {
    nbDots = 1;
    board.convertBoard(toConvert);
    nbDots -= 1;
    direction = 'i';
    appearance = 0;
    win = false;
    lost = false;
  }
  
  void newGame() {
    nbDots = 1;
    board.convertBoard(lines);
    nbDots -= 1;
    direction = 'i';
    scoreJoueur = 0;
    appearance = 0;
    nbVies = 2;
    nbPtVieSupp = 1000;
    win = false;
    lost = false;
  }
  
  void update(){
    board.cells[pacman.cellY][pacman.cellX] = TypeCell.PATH;
    board.cells[redGhost.cellY][redGhost.cellX] = TypeCell.PATH;
    pacman.cellX = 11;
    pacman.cellY = 17;
    redGhost.cellX = 11;
    redGhost.cellY = 9;
    board.cells[9][11] = TypeCell.GHOST;
    board.cells[17][11] = TypeCell.PACMAN;
    direction = 'i';
  }

  void startTime() {
    if (millis() > timer) {
      superScore = 200;
      boosted = false;
    }
  }

  void drawIt() {
    if (win == true) {
      highestScores = append(highestScores, str(scoreJoueur));
      saveStrings("./data/scores.txt", highestScores);
      fill(255, 255, 0);
      textAlign(CENTER, CENTER);
      text("YOU WON", width/2, height/2);
      noLoop();
    } else if (lost == true) {
      board.drawIt();
      // effet de mort de pacman
      if (appearance < 13) {
        if (appearance >= 11) {
          appearance += 0.05;
        } else {
          appearance += 0.15;
        }
        if(appearance == 1.2){
          println(scoreJoueur);
          highestScores = append(highestScores, str(scoreJoueur));
          printArray(highestScores);
        }
      }

      textFont(f, 12);
      fill(255, 50, 50);
      textAlign(CENTER, CENTER);
      PVector pos = board.getCellCenter(board.nbCellsX/2, 13);
      text("Game Over !", pos.x, pos.y-2);
    } else {
      loop();
      // affichage du Ready!
      if (millis() < 6000) {
        textFont(f, 12);
        fill(255, 255, 0);
        textAlign(CENTER, CENTER);
        PVector pos = board.getCellCenter(board.nbCellsX/2, 13);
        text("Ready !", pos.x, pos.y-2);
      }
      // score
      textFont(f, 16);
      fill(255);
      textAlign(LEFT, UP);
      text(scoreJoueur, board.boardX, height/4.5);
      textAlign(CENTER, UP);
      text("High Score", width/2+CELL_SIZE/2, height/5.5);
      highScore = sortedScores[0];
      text(highScore, width/2+CELL_SIZE/2, height/4.5);
      // affichage du board
      board.drawIt();
      if ( boosted == true) {
        startTime();
      }

      // permet de faire clignoter les super dots
      if (millis() > blinkTimer*2) {
        blink = color(255, 200, 100);
        if (millis() > (blinkTimer*2)+500) {
          blinkTimer += 500;
        }
      } else if (millis() > blinkTimer) {
        blink = color(0, 0, 0, 255);
      }

      if (scoreJoueur >= nbPtVieSupp) {
        if(nbVies < 2){
          nbVies += 1;
          nbPtVieSupp += 1000;
        }
      }

      // gestion du bonus ( n'apparaissent qu'apres 15s de jeu
      if (millis() > tBonus) {
        
        // POUR FAIRE SORTIR LES FANTOMES LES UNS APRES LES AUTRES
        
        if (posY > 1 && board.cells[posY][posX] != TypeCell.WALL &&
          board.cells[posY][posX] != TypeCell.GHOST &&
          board.cells[posY][posX] != TypeCell.PACMAN &&
          board.cells[posY][posX] != TypeCell.EMPTY) {
          if(board.cells[posY][posX] == TypeCell.DOT || board.cells[posY][posX] == TypeCell.SUPER_DOT){
            nbDots -= 1;
          }
          board.cells[posY][posX] = TypeCell.BONUS;
        } else {
          bonusX = random(board.nbCellsX);
          bonusY = random(board.nbCellsY);
          posX = int(bonusX);
          posY = int(bonusY);
        }
      }

      // affichage des vies
      for (int i=0; i<nbVies; i++) {
        image(pacmanLeft, (width/4)+(i*45), height/1.2, 27, 27);
      }
    }
    // condition de victoire
    if (nbDots == 0 ) {
      win = true;
    }
    if (nbVies < 0) {
      lost = true;
    }
  }

  void saveGame() {
    // le fichier liste va permettre de connaitre le nombre de sauvegardes
    // et le nom de chaques sauvegardes
    String[] liste = loadStrings("./data/liste.txt");
    
    String[] newTxt = new String[0];
    TypeCell[][] c = board.cells;
    // pour nommer les sauvegardes
    int d = day();
    int mo = month();
    int h = hour();
    int m = minute();
    int s = second();
    for(int i=-1; i<c.length; i++){
      String line = "";
      if(i < 0){
        line = d+"_"+mo+"_"+h+"h"+m+"."+s+" "+scoreJoueur+" "+nbVies;
      }
      else {
        for(int j=0; j<c[i].length; j++){
          if (c[i][j] == TypeCell.WALL) {
            line += "x";
          } else if (c[i][j] == TypeCell.EMPTY) {
            line += "V";
          } else if (c[i][j] == TypeCell.GHOST) {
            line += "G";
          } else if (c[i][j] == TypeCell.PACMAN) {
            line += "P";
          } else if (c[i][j] == TypeCell.DOT) {
            line += "o";
          } else if (c[i][j] == TypeCell.SUPER_DOT) {
            line += "O";
          } else if (c[i][j] == TypeCell.PATH) {
            line += "R";
          } else if (c[i][j] == TypeCell.BONUS) {
            line += "R";
          }
        }
      }
      if(i != 0){
        newTxt = append(newTxt, line);
      }
    }
    liste = append(liste, newTxt[0]);
    saveStrings("./data/liste.txt", liste);
    saveStrings("./levels/"+d+"_"+mo+"_"+h+"h"+m+"."+s+".txt", newTxt);
  }
}
