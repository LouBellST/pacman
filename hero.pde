class Hero {
  // position on screen
  PVector position;
  PVector posOffset;
  // position on board
  int cellX, cellY;
  float size;

  // move data
  boolean moving; // is moving ?
  PVector dir;

  Hero(int x, int y) {
    cellX = x;
    cellY = y;
    position = new PVector(board.getCellCenter(x, y).x, board.getCellCenter(x, y).y);
    size = board.cellSize;
    dir = new PVector(cellX, cellY);
  }

  void lauchMove() {
    posPX = pacman.position.x;
    posPY = pacman.position.y;
    if (appearance == 0) {
      // direction devant
      if (direction == 'f') {
        // si case suivante pas un mur
        if ((board.cells[cellY-1][cellX] != TypeCell.WALL) && (board.cells[cellY-1][cellX] != TypeCell.EMPTY)) {
          // si case suivante dot ou super dot
          animate = true;
          if (board.cells[cellY-1][cellX] == TypeCell.DOT) {
            scoreJoueur += SCORE_DOT;
            nbDots -= 1;
          } else if (board.cells[cellY-1][cellX] == TypeCell.SUPER_DOT) {
            scoreJoueur += SCORE_SUPER_DOT;
            nbDots -= 1;
            boosted = true;
            timer = millis()+5000;
          } else if (board.cells[cellY-1][cellX] == TypeCell.BONUS) {
            // bonus ajoute 500pts et remet un delai de 15s avant qu'un autre apparaisse
            scoreJoueur += SCORE_BONUS;
            tBonus = millis() + 15000;
            bonusX = random(board.nbCellsX);
            bonusY = random(board.nbCellsY);
            posX = int(bonusX);
            posY = int(bonusY);
          }
          dir = new PVector(cellX, cellY-1);
          board.cells[cellY-1][cellX] = TypeCell.PACMAN;
          board.cells[cellY][cellX] = TypeCell.PATH;
          cellY -= board.cellSize; 
        } else {
          animate = false;
        }
      }

      // direction derriere
      else if (direction == 'b') {
        // si case suivante pas un mur
        if ((board.cells[cellY+1][cellX] != TypeCell.WALL) && (board.cells[cellY+1][cellX] != TypeCell.EMPTY)) {
          animate = true;
          // si case suivante dot ou super dot
          if (board.cells[cellY+1][cellX] == TypeCell.DOT) {
            scoreJoueur += SCORE_DOT;
            nbDots -= 1;
          } else if (board.cells[cellY+1][cellX] == TypeCell.SUPER_DOT) {
            scoreJoueur += SCORE_SUPER_DOT;
            nbDots -= 1;
            boosted = true;
            timer = millis()+5000;
          } else if (board.cells[cellY+1][cellX] == TypeCell.BONUS) {
            // bonus ajoute 500pts et remet un delai de 15s avant qu'un autre apparaisse
            scoreJoueur += SCORE_BONUS;
            tBonus = millis() + 15000;
            bonusX = random(board.nbCellsX);
            bonusY = random(board.nbCellsY);
            posX = int(bonusX);
            posY = int(bonusY);
          }
          dir = new PVector(cellX, cellY+1);
          board.cells[cellY+1][cellX] = TypeCell.PACMAN;
          board.cells[cellY][cellX] = TypeCell.PATH;
          cellY += board.cellSize;
        } else {
          animate = false;
        }
      }

      // direction gauche
      else if (direction == 'l') {
        if (cellX-1 <0) {
          // si case suivante dot ou super dot
          if (board.cells[cellY][board.nbCellsX-1] == TypeCell.DOT) {
            scoreJoueur += SCORE_DOT;
            nbDots -= 1;
          } else if (board.cells[cellY][board.nbCellsX-1] == TypeCell.SUPER_DOT) {
            scoreJoueur += SCORE_SUPER_DOT;
            nbDots -= 1;
            boosted = true;
            timer = millis()+5000;
          } else if (board.cells[cellY][board.nbCellsX-1] == TypeCell.BONUS) {
            // bonus ajoute 500pts et remet un delai de 15s avant qu'un autre apparaisse
            scoreJoueur += SCORE_BONUS;
            tBonus = millis() + 15000;
            bonusX = random(board.nbCellsX);
            bonusY = random(board.nbCellsY);
            posX = int(bonusX);
            posY = int(bonusY);
          }
          dir = new PVector(board.nbCellsX-1, cellY);
          board.cells[cellY][board.nbCellsX-1] = TypeCell.PACMAN;
          board.cells[cellY][cellX] = TypeCell.PATH;
          cellX = board.nbCellsX*board.cellSize;
        }
        // si case suivante pas un mur
        else if ((board.cells[cellY][cellX-1] != TypeCell.WALL) && (board.cells[cellY][cellX-1] != TypeCell.EMPTY)) {
          animate = true;
          // si case suivante dot ou super dot
          if (board.cells[cellY][cellX-1] == TypeCell.DOT) {
            scoreJoueur += SCORE_DOT;
            nbDots -= 1;
          } else if (board.cells[cellY][cellX-1] == TypeCell.SUPER_DOT) {
            scoreJoueur += SCORE_SUPER_DOT;
            nbDots -= 1;
            boosted = true;
            timer = millis()+5000;
          } else if (board.cells[cellY][cellX-1] == TypeCell.BONUS) {
            // bonus ajoute 500pts et remet un delai de 15s avant qu'un autre apparaisse
            scoreJoueur += SCORE_BONUS;
            tBonus = millis() + 15000;
            bonusX = random(board.nbCellsX);
            bonusY = random(board.nbCellsY);
            posX = int(bonusX);
            posY = int(bonusY);
          }
          dir = new PVector(cellX-1, cellY);
          board.cells[cellY][cellX-1] = TypeCell.PACMAN;
          board.cells[cellY][cellX] = TypeCell.PATH;
          cellX -= board.cellSize;
        } else {
          animate = false;
        }
      }

      // direction droite
      else if (direction == 'r') {
        if (cellX+1 == board.nbCellsX) {
          // si case suivante dot ou super dot
          if (board.cells[cellY][0] == TypeCell.DOT) {
            scoreJoueur += SCORE_DOT;
            nbDots -= 1;
          } else if (board.cells[cellY][0] == TypeCell.SUPER_DOT) {
            scoreJoueur += SCORE_SUPER_DOT;
            nbDots -= 1;
            boosted = true;
            timer = millis()+5000;
          } else if (board.cells[cellY][0] == TypeCell.BONUS) {
            // bonus ajoute 500pts et remet un delai de 15s avant qu'un autre apparaisse
            scoreJoueur += SCORE_BONUS;
            tBonus = millis() + 15000;
            bonusX = random(board.nbCellsX);
            bonusY = random(board.nbCellsY);
            posX = int(bonusX);
            posY = int(bonusY);
          }
          dir = new PVector(0, cellY);
          board.cells[cellY][0] = TypeCell.PACMAN;
          board.cells[cellY][cellX] = TypeCell.PATH;
          cellX = 0;
        }
        // si case suivante pas un mur
        else if ((board.cells[cellY][cellX+1] != TypeCell.WALL) && (board.cells[cellY][cellX+1] != TypeCell.EMPTY)) {
          animate = true;
          // si case suivante dot ou super dot
          if (board.cells[cellY][cellX+1] == TypeCell.DOT) {
            scoreJoueur += SCORE_DOT;
            nbDots -= 1;
          } else if (board.cells[cellY][cellX+1] == TypeCell.SUPER_DOT) {
            scoreJoueur += SCORE_SUPER_DOT;
            nbDots -= 1;
            boosted = true;
            timer = millis()+5000;
          } else if (board.cells[cellY][cellX+1] == TypeCell.BONUS) {
            // bonus ajoute 500pts et remet un delai de 15s avant qu'un autre apparaisse
            scoreJoueur += SCORE_BONUS;
            tBonus = millis() + 15000;
            bonusX = random(board.nbCellsX);
            bonusY = random(board.nbCellsY);
            posX = int(bonusX);
            posY = int(bonusY);
          }
          dir = new PVector(cellX+1, cellY);
          board.cells[cellY][cellX+1] = TypeCell.PACMAN;
          board.cells[cellY][cellX] = TypeCell.PATH;
          cellX += board.cellSize;
        } else {
          animate = false;
        }
      }
    }
  }

  void move() {
    // haut
    if ((key == 'Z') || (key == 'z') || (key == CODED && keyCode == UP) && isMenu == false) {
      // Si la direction n'est pas un mur
      direction = 'f';
    }

    // bas
    else if ((key == 'S') || (key == 's') || (key == CODED && keyCode == DOWN) && isMenu == false) {
      // Si la direction n'est pas un mur
      direction = 'b';
    }

    // gauche
    else if ((key == 'Q') || (key == 'q') || (key == CODED && keyCode == LEFT) && isMenu == false) {
      direction = 'l';
    }

    // droite
    else if ((key == 'D') || (key == 'd') || (key == CODED && keyCode == RIGHT) && isMenu == false) {
      direction = 'r';
    }
  }

  void update(Board board) {
  }

  void drawIt() {
    if(animate == true){
      if(direction == 'f'){
        posPY -= intervalle;
      } else if(direction == 'b'){
        posPY += intervalle;
      } else if(direction == 'l'){
        posPX -= intervalle;
      } else if(direction == 'r'){
        posPX += intervalle;
      }
    }
    if(appearance == 0){
      fill(255, 255, 0);
      noStroke();
      circle(posPX, posPY, pacman.size);
    }
    imageMode(CENTER);
    if (appearance > 12) {
    } else if (appearance > 11) {
      image(pac11, position.x, position.y, size, size);
    } else if (appearance > 10) {
      image(pac10, position.x, position.y, size, size);
    } else if (appearance > 9) {
      image(pac9, position.x, position.y, size, size);
    } else if (appearance > 8) {
      image(pac8, position.x, position.y, size, size);
    } else if (appearance > 7) {
      image(pac7, position.x, position.y, size, size);
    } else if (appearance > 6) {
      image(pac6, position.x, position.y, size, size);
    } else if (appearance > 5) {
      image(pac5, position.x, position.y, size, size);
    } else if (appearance > 4) {
      image(pac4, position.x, position.y, size, size);
    } else if (appearance > 3) {
      image(pac3, position.x, position.y, size, size);
    } else if (appearance > 2) {
      image(pac2, position.x, position.y, size, size);
    } else if (appearance > 1) {
      image(pac1, position.x, position.y, size, size);
    }  /*else if (direction == 'l' || direction == 'L') {
      image(pacmanLeft, position.x, position.y, size, size);
    } else if (direction == 'r' || direction == 'R') {
      image(pacmanRight, position.x, position.y, size, size);
    } else if (direction == 'b') {
      image(pacmanDown, position.x, position.y, size, size);
    } else if (direction == 'f') {
      image(pacmanUp, position.x, position.y, size, size);
    } else {
      image(pacmanFull, position.x, position.y, size, size);
    }
    */
  }
}
