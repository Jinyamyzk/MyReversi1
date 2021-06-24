
class Ai {
  Board board;
  int stoneColor;
  int maxDepth;

  Ai(Board board, int maxDepth) {
    this.board = board;
    this.stoneColor = -1;// 白
    this.maxDepth = maxDepth;
  }



  Cell think(Board b, int stoneColor) {
    Tuple bestCell = null;
    int depth = 0;
    bestCell = searchBoardTree1(b, stoneColor, depth);

    return bestCell.c;
  }   

  Tuple searchBoardTree1(Board b, int stoneColor, int depth) {
    ArrayList<Tuple> v_list = new ArrayList<Tuple>();
    ArrayList<Cell> candidates = b.getEmptyCells();
    Tuple bestCell = null;
    if (depth >= this.maxDepth || candidates.size()==0) {
      int count = evaluate(candidates, b);
      bestCell = new Tuple(null, count);
    } else {
      for (Cell cell : candidates) {
        ArrayList<Cell> cellsToFlip = b.cellsToFlipWith(cell, stoneColor);
        if (cellsToFlip.size() == 0) {
          continue;
        } else {
          // 石を置いて
          cell.putStone(stoneColor);  
          // それぞれひっくり返す
          for (Cell c : cellsToFlip) {
            c.flip();
          }
          int nextStone = stoneColor * -1;
          Tuple value = searchBoardTree2(b, nextStone, depth+1);
          value.c = cell;
          v_list.add(value);
          for (Cell c : cellsToFlip) {
            c.flip();
          }
          cell.removeStone();
        }
      }
      if (v_list.size() == 0) {
        int nextStone = stoneColor * -1;
        Tuple value = searchBoardTree1(b, nextStone, depth+1);
        value.c = null;
        v_list.add(value);
      }
      int max = -100;
      for (Tuple t : v_list) {
        if (t.v > max) {
          max = t.v;
          bestCell = t;
        }
      }
    }
    return bestCell;
  }

  Tuple searchBoardTree2(Board b, int stoneColor, int depth) {
    ArrayList<Tuple> v_list = new ArrayList<Tuple>();
    ArrayList<Cell> candidates = b.getEmptyCells();
    Tuple bestCell = null;
    if (depth >= this.maxDepth || candidates.size()==0) {
      int count = evaluate(candidates, b);
      bestCell = new Tuple(null, count);
    } else {
      for (Cell cell : candidates) {
        ArrayList<Cell> cellsToFlip = b.cellsToFlipWith(cell, stoneColor);
        if (cellsToFlip.size() == 0) {
          continue;
        } else {
          // 石を置いて
          cell.putStone(stoneColor);  
          // それぞれひっくり返す
          for (Cell c : cellsToFlip) {
            c.flip();
          }
          int nextStone = stoneColor * -1;
          Tuple value = searchBoardTree1(b, nextStone, depth+1);
          value.c = cell;
          v_list.add(value);
          for (Cell c : cellsToFlip) {
            c.flip();
          }
          cell.removeStone();
        }
      }
      if (v_list.size() == 0) {
        int nextStone = stoneColor * -1;
        Tuple value = searchBoardTree1(b, nextStone, depth+1);
        value.c = null;
        v_list.add(value);
      }
      int min = 100;
      for (Tuple t : v_list) {
        if (t.v < min) {
          min = t.v;
          bestCell = t;
        }
      }
    }
    return bestCell;
  }

  int evaluate(ArrayList<Cell> candidates, Board b) {
    int count=0;
    for (Cell cell : candidates) {
      ArrayList<Cell> cellsToFlip = b.cellsToFlipWith(cell, stoneColor);
      if (cellsToFlip.size() != 0) {
        count++; //打てる数の計算
      }
    }
    return count;
  }
}
