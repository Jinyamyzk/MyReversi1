
class Ai {
  Board board;
  int stoneColor;
  int maxDepth;

  Ai(Board board, int maxDepth) {
    this.board = board;
    this.stoneColor = -1;// 白
    this.maxDepth = maxDepth; 
  }

  /**
  * どのマスに置くか考える
  * いまのところは愚直に一番ひっくりかえせる数が多いのを選んでる
  * そのうち2〜３手先を計算するようにするつもり
  * @return 置くマス
  */
  Cell think(Board b, int stoneColor) {
    Tuple bestCell = null;
    int depth = 0;
    bestCell = searchBoardTree1(b, stoneColor, depth);
    
    return bestCell.c;
  }   
  
  Tuple searchBoardTree1(Board b, int stoneColor, int depth){
    ArrayList<Tuple> v_list = new ArrayList<Tuple>();
    ArrayList<Cell> candidates = b.getEmptyCells();
    Tuple bestCell = null;
    if (depth >= this.maxDepth){
      int count = evaluate(candidates);
      bestCell = new Tuple(null, count);
    } else {
    for (Cell cell: candidates){
      ArrayList<Cell> cellsToFlip = b.cellsToFlipWith(cell,  stoneColor);
      if (cellsToFlip.size() == 0){
        continue;
      } else {
        // 石を置いて
        cell.putStone(stoneColor);  
        // それぞれひっくり返す
        for(Cell c: cellsToFlip){
          c.flip();
        }
        int nextStone = stoneColor * -1;
        Tuple value = searchBoardTree2(b, nextStone, depth+1);
        value.c = cell;
        v_list.add(value);
        for(Cell c: cellsToFlip){
          c.flip();
        }
        cell.removeStone();
      }   
      int min = 100;
      for (Tuple t: v_list){
        if (t.v < min){
          min = t.v;
          bestCell = t;
        }
      }
    }
   
    return bestCell;
  }
  
  Tuple searchBoardTree2(Board b, int stoneColor, int depth){
    ArrayList<Cell> candidates = b.getEmptyCells();
    
    }
    return bestCell;
  }
  
  int evaluate(ArrayList<Cell> candidates){
    int count=0;
    for (Cell cell: candidates){
      ArrayList<Cell> cellsToFlip = b.cellsToFlipWith(cell,  stoneColor);
      if (cellsToFlip.size() != 0){
        count++; //打てる数の計算
      }
    }
    return count;
  }
  
}
