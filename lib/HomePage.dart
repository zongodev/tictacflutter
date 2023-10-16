import 'package:flutter/material.dart';
import 'package:tictac/game_logic.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String activePlayer = "X";
  bool gameOver = false;
  int turn = 0;
  String result = "";
  Game gm = Game();
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SwitchListTile.adaptive(
                value: isClicked,
                title: const Text("Turn on/off two player"),
                onChanged: (newvl) {
                  setState(() {
                    isClicked = newvl;
                  });
                }),
            Text(
              "It's $activePlayer player",
              style: const TextStyle(
                fontSize: 28,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: GridView.count(
              padding: const EdgeInsets.all(16),
              crossAxisCount: 3,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              children: List.generate(
                9,
                (index) => InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: gameOver ? null : () => _onTap(index),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.indigo,
                    ),
                    child: Center(
                      child: Text(
                        Player.playerX.contains(index)
                            ? "x"
                            : Player.playerO.contains(index)
                                ? "O"
                                : "",
                        style: TextStyle(
                            fontSize: 50,
                            color: Player.playerX.contains(index)
                                ? Colors.red
                                : Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
            )),
            Text(result),
            ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    result = '';
                    gameOver = false;
                    activePlayer = "X";
                    turn = 0;
                    Player.playerX = [];
                    Player.playerO = [];
                  });
                },
                icon: const Icon(Icons.restart_alt),
                label: const Text("Repeat the game")),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  _onTap(int index) async {
    if ((Player.playerX.isEmpty || !Player.playerX.contains(index)) &&
        (Player.playerO.isEmpty || !Player.playerO.contains(index))) {
      gm.playGame(index, activePlayer);
      updateState();
    }
    if (!isClicked && !gameOver) {
      await gm.vsPhone(activePlayer);
      updateState();
    }
  }

  void updateState() {
    setState(() {
      activePlayer = activePlayer == "X" ? "O" : "X";
      turn++;
      String winnerPlayer=gm.checkWinner();
      if (winnerPlayer!=""){
        gameOver=true;
        result="$winnerPlayer is the winner";
      }
      else if(!gameOver && turn==9){
        result="It's Draw";
      }
    });
  }
}
