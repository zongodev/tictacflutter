import 'dart:math';

extension ContainsAll on List{
  containsAll(int x, int y, int z) {
    return contains(x) && contains(y) && contains(z);
  }
}

class Game {
  void playGame(int index, String activePlayer) {
    activePlayer == Player.x
        ? Player.playerX.add(index)
        : Player.playerO.add(index);
  }

  Future<void> vsPhone(activePlayer) async {
    List<int> emptyCells = [];
    for (int i = 0; i < 9; i++) {
      if (!(Player.playerX.contains(i) || Player.playerO.contains(i))) {
        emptyCells.add(i);
      }
    }
    Random r = Random();
    int randomIndex = r.nextInt(emptyCells.length);
    int newIndex = emptyCells[randomIndex];
    playGame(newIndex, activePlayer);
  }

  String checkWinner() {
    String winner="";
    if (Player.playerX.containsAll(0, 1, 2) ||
        Player.playerX.containsAll(3, 4, 5) ||
        Player.playerX.containsAll(6, 7, 8) ||
        Player.playerX.containsAll(0, 3, 6) ||
        Player.playerX.containsAll(1, 4, 7) ||
        Player.playerX.containsAll(2, 5, 8)||
        Player.playerX.containsAll(0, 4, 8)||
        Player.playerX.containsAll(2, 4, 6) )
    { winner="X";}
    else if (
    Player.playerO.containsAll(0, 1, 2) ||
        Player.playerO.containsAll(3, 4, 5) ||
        Player.playerO.containsAll(6, 7, 8) ||
        Player.playerO.containsAll(0, 3, 6) ||
        Player.playerO.containsAll(1, 4, 7) ||
        Player.playerO.containsAll(0, 4, 8)||
        Player.playerO.containsAll(2, 5, 8)||
        Player.playerO.containsAll(2, 4, 6)
    ) {
      winner="O";
    }else {
      winner="";
    }
    return winner;
  }
}

class Player {
  static const x = "X";
  static const o = "O";
  static const empty = "";
  static List<int> playerX = [];
  static List<int> playerO = [];
}
