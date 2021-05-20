
class Ai {
  Board board;
  int stoneColor;

  Ai(Board board) {
    this.board = board;
    this.stoneColor = -1; // 白
  }

  /**
  * どのマスに置くか考える
  * いまのところは愚直に一番ひっくりかえせる数が多いのを選んでる
  * そのうち2〜３手先を計算するようにするつもり
  * @return 置くマス
  */
  Cell think() {
    int boardValue = board.evalBoard(stoneColor);
    int max = 0;
    Cell bestCell = null;
    Board copy = this.board.copy();
    ArrayList<Cell> candidates = board.getEmptyCells();
    for(Cell cell: candidates) {
      ArrayList<Cell> cellsToFlip = board.cellsToFlipWith(cell,  stoneColor);
      if(max < cellsToFlip.size()){
        max = cellsToFlip.size();
        bestCell = cell;
      }
    }
    return bestCell;
  }   
}
