class Ghost {
  PVector position;
  // si le fantome est sorti de la cage ou pas
  boolean out;
  float size;
  PImage col;
  int cellX, cellY;

  Ghost(PImage _col, int x, int y) {
    col = _col;
    size = board.cellSize/1.2;
    position = new PVector(board.getCellCenter(x, y).x, board.getCellCenter(x, y).y);
    cellX = x;
    cellY = y;

    out = false;
  }

  // pas encore parfait notament dans les coins le fantome fait des allers/retours en boucle
  // et des fois il s'arrete sur place sans raison
  // mais sinon il bouge


  void move() {
    float targetX = pacman.dir.x;
    float targetY = pacman.dir.y;
    // si le fantome est moins loin que pacman
    if(cellX < targetX){
      // si le fantome est moins haut que pacman
      if(cellY < targetY){
        if(board.cells[cellY+1][cellX] != TypeCell.WALL && board.cells[cellY+1][cellX] != TypeCell.EMPTY){
          board.cells[cellY+1][cellX] = TypeCell.GHOST;
          board.cells[cellY][cellX] = TypeCell.PATH;
          cellY += board.cellSize;
        } else if (board.cells[cellY][cellX+1] != TypeCell.WALL && board.cells[cellY][cellX+1] != TypeCell.EMPTY){
          board.cells[cellY][cellX+1] = TypeCell.GHOST;
          board.cells[cellY][cellX] = TypeCell.PATH;
          cellX += board.cellSize;
        } else if(board.cells[cellY-1][cellX] != TypeCell.WALL && board.cells[cellY-1][cellX] != TypeCell.EMPTY){
          board.cells[cellY-1][cellX] = TypeCell.GHOST;
          board.cells[cellY][cellX] = TypeCell.PATH;
          cellY -= board.cellSize;
        } 
      } 
      // si le fantome est plus haut que pacman
      else if(cellY > targetY){
        if(board.cells[cellY-1][cellX] != TypeCell.WALL && board.cells[cellY-1][cellX] != TypeCell.EMPTY){
          board.cells[cellY-1][cellX] = TypeCell.GHOST;
          board.cells[cellY][cellX] = TypeCell.PATH;
          cellY -= board.cellSize;
        } else if (board.cells[cellY][cellX+1] != TypeCell.WALL && board.cells[cellY][cellX+1] != TypeCell.EMPTY){
          board.cells[cellY][cellX+1] = TypeCell.GHOST;
          board.cells[cellY][cellX] = TypeCell.PATH;
          cellX += board.cellSize;
        } else if(board.cells[cellY+1][cellX] != TypeCell.WALL && board.cells[cellY+1][cellX] != TypeCell.EMPTY){
          board.cells[cellY+1][cellX] = TypeCell.GHOST;
          board.cells[cellY][cellX] = TypeCell.PATH;
          cellY += board.cellSize;
        } 
      }
      // si le fantome est aussi haut que pacman
      else if(cellY == targetY){
        if(board.cells[cellY][cellX+1] != TypeCell.WALL && board.cells[cellY][cellX+1] != TypeCell.EMPTY){
          board.cells[cellY][cellX+1] = TypeCell.GHOST;
          board.cells[cellY][cellX] = TypeCell.PATH;
          cellX += board.cellSize;
        } else if (board.cells[cellY-1][cellX] != TypeCell.WALL && board.cells[cellY-1][cellX] != TypeCell.EMPTY){
          board.cells[cellY-1][cellX] = TypeCell.GHOST;
          board.cells[cellY][cellX] = TypeCell.PATH;
          cellY -= board.cellSize;
        } else if (board.cells[cellY][cellX-1] != TypeCell.WALL && board.cells[cellY][cellX-1] != TypeCell.EMPTY){
          board.cells[cellY][cellX-1] = TypeCell.GHOST;
          board.cells[cellY][cellX] = TypeCell.PATH;
          cellX -= board.cellSize;
        } else if (board.cells[cellY+1][cellX] != TypeCell.WALL && board.cells[cellY+1][cellX] != TypeCell.EMPTY) {
          board.cells[cellY+1][cellX] = TypeCell.GHOST;
          board.cells[cellY][cellX] = TypeCell.PATH;
          cellY += board.cellSize;
        }
      }
    } 
    // si le fantome est plus loin que pacman
    else if(cellX > targetX){
      // si le fantome est moins haut que pacman
      if(cellY < targetY){
        if(board.cells[cellY+1][cellX] != TypeCell.WALL && board.cells[cellY+1][cellX] != TypeCell.EMPTY){
          board.cells[cellY+1][cellX] = TypeCell.GHOST;
          board.cells[cellY][cellX] = TypeCell.PATH;
          cellY += board.cellSize;
        } else if (board.cells[cellY][cellX-1] != TypeCell.WALL && board.cells[cellY][cellX-1] != TypeCell.EMPTY){
          board.cells[cellY][cellX-1] = TypeCell.GHOST;
          board.cells[cellY][cellX] = TypeCell.PATH;
          cellX -= board.cellSize;
        } else if(board.cells[cellY-1][cellX] != TypeCell.WALL && board.cells[cellY-1][cellX] != TypeCell.EMPTY){
          board.cells[cellY-1][cellX] = TypeCell.GHOST;
          board.cells[cellY][cellX] = TypeCell.PATH;
          cellY -= board.cellSize;
        } 
      } 
      // si le fantome est plus haut que pacman
      else if(cellY > targetY){
        if(board.cells[cellY-1][cellX] != TypeCell.WALL && board.cells[cellY-1][cellX] != TypeCell.EMPTY){
          board.cells[cellY-1][cellX] = TypeCell.GHOST;
          board.cells[cellY][cellX] = TypeCell.PATH;
          cellY -= board.cellSize;
        } else if (board.cells[cellY][cellX-1] != TypeCell.WALL && board.cells[cellY][cellX-1] != TypeCell.EMPTY){
          board.cells[cellY][cellX-1] = TypeCell.GHOST;
          board.cells[cellY][cellX] = TypeCell.PATH;
          cellX -= board.cellSize;
        } else if(board.cells[cellY+1][cellX] != TypeCell.WALL && board.cells[cellY+1][cellX] != TypeCell.EMPTY){
          board.cells[cellY+1][cellX] = TypeCell.GHOST;
          board.cells[cellY][cellX] = TypeCell.PATH;
          cellY += board.cellSize;
        } 
      } 
      // si le fantome est aussi haut que pacman
      else if(cellY == targetY){
        if(board.cells[cellY][cellX-1] != TypeCell.WALL && board.cells[cellY][cellX-1] != TypeCell.EMPTY){
          board.cells[cellY][cellX-1] = TypeCell.GHOST;
          board.cells[cellY][cellX] = TypeCell.PATH;
          cellX -= board.cellSize;
        } else if (board.cells[cellY-1][cellX] != TypeCell.WALL && board.cells[cellY-1][cellX] != TypeCell.EMPTY){
          board.cells[cellY-1][cellX] = TypeCell.GHOST;
          board.cells[cellY][cellX] = TypeCell.PATH;
          cellY -= board.cellSize;
        } else if (board.cells[cellY][cellX+1] != TypeCell.WALL && board.cells[cellY][cellX+1] != TypeCell.EMPTY){
          board.cells[cellY][cellX+1] = TypeCell.GHOST;
          board.cells[cellY][cellX] = TypeCell.PATH;
          cellX += board.cellSize;
        } else if (board.cells[cellY+1][cellX] != TypeCell.WALL && board.cells[cellY+1][cellX] != TypeCell.EMPTY) {
          board.cells[cellY+1][cellX] = TypeCell.GHOST;
          board.cells[cellY][cellX] = TypeCell.PATH;
          cellY += board.cellSize;
        }
      }
    } 
    // si le fantome est sur la meme colonne que pacman
    else if(cellX == targetX){
      // si le fantome est moins haut que pacman
      if(cellY < targetY){
        if(board.cells[cellY+1][cellX] != TypeCell.WALL && board.cells[cellY+1][cellX] != TypeCell.EMPTY){
            board.cells[cellY+1][cellX] = TypeCell.GHOST;
            board.cells[cellY][cellX] = TypeCell.PATH;
            cellY += board.cellSize; 
          } else if (board.cells[cellY][cellX-1] != TypeCell.WALL && board.cells[cellY][cellX-1] != TypeCell.EMPTY){
            board.cells[cellY][cellX-1] = TypeCell.GHOST;
            board.cells[cellY][cellX] = TypeCell.PATH;
            cellX -= board.cellSize;
          } else if (board.cells[cellY-1][cellX] != TypeCell.WALL && board.cells[cellY-1][cellX] != TypeCell.EMPTY){
            board.cells[cellY-1][cellX] = TypeCell.GHOST;
            board.cells[cellY][cellX] = TypeCell.PATH;
            cellY -= board.cellSize;
          } else if (board.cells[cellY][cellX+1] != TypeCell.WALL && board.cells[cellY][cellX+1] != TypeCell.EMPTY) {
            board.cells[cellY][cellX+1] = TypeCell.GHOST;
            board.cells[cellY][cellX] = TypeCell.PATH;
            cellX += board.cellSize;
        }
      } 
      // si le fantome est plus haut que pacman
      else if(cellY > targetY){
        if(board.cells[cellY-1][cellX] != TypeCell.WALL && board.cells[cellY-1][cellX] != TypeCell.EMPTY){
          board.cells[cellY-1][cellX] = TypeCell.GHOST;
          board.cells[cellY][cellX] = TypeCell.PATH;
          cellY -= board.cellSize;
        } else if (board.cells[cellY][cellX-1] != TypeCell.WALL && board.cells[cellY][cellX-1] != TypeCell.EMPTY){
          board.cells[cellY][cellX-1] = TypeCell.GHOST;
          board.cells[cellY][cellX] = TypeCell.PATH;
          cellX -= board.cellSize;
        } else if (board.cells[cellY+1][cellX] != TypeCell.WALL && board.cells[cellY+1][cellX] != TypeCell.EMPTY){
          board.cells[cellY+1][cellX] = TypeCell.GHOST;
          board.cells[cellY][cellX] = TypeCell.PATH;
          cellY += board.cellSize;
        }  else if (board.cells[cellY][cellX+1] != TypeCell.WALL && board.cells[cellY][cellX+1] != TypeCell.EMPTY) {
          board.cells[cellY][cellX+1] = TypeCell.GHOST;
          board.cells[cellY][cellX] = TypeCell.PATH;
          cellX += board.cellSize;
        }
      } 
      // si le fantome va touche pacman
      else if(cellY == targetY){
        board.cells[int(targetY)][cellX] = TypeCell.GHOST;
        board.cells[cellY][cellX] = TypeCell.PATH;
        cellY += int(targetY);
      }
    }
  }

  void drawIt() {
    imageMode(CENTER);
    image(col, position.x, position.y, size, size);
  }
}
