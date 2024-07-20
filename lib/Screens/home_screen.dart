import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isTurnO = true;
  List<String> xOrOList = ['', '', '', '', '', '', '', '', ''];

  var filledBoxes = 0;
  bool gameHasResult = false;

  int scoreX = 0;
  int scoreO = 0;
  String winnerTitle = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey[900],
          title: Text('TicTacToe'),
          actions: [
            IconButton(
                onPressed: () {
                  clearGame();
                  clearScore();
                },
                icon: Icon(Icons.refresh))
          ],
        ),
        backgroundColor: Colors.grey[900],
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              getScoreBored(),
              SizedBox(
                height: 20,
              ),
              getResultButton(),
              SizedBox(
                height: 20,
              ),
              getGridView(),
              getTurn(),
            ],
          ),
        ));
  }

  Widget getScoreBored() {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Player O',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  '$scoreO',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Player X',
                  style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                '$scoreX',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget getGridView() {
    return Expanded(
      child: GridView.builder(
        itemCount: 9,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              tapped(index);
            },
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Center(
                child: Text(
                  xOrOList[index],
                  style: TextStyle(
                      fontSize: 100,
                      fontWeight: FontWeight.bold,
                      color:
                          xOrOList[index] == 'X' ? Colors.yellow : Colors.red),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void tapped(int index) {
    if (gameHasResult) {
      return;
    }
    setState(() {
      if (xOrOList[index] != '') {
        return;
      }
      if (isTurnO) {
        xOrOList[index] = 'O';
        filledBoxes = filledBoxes + 1;
      } else {
        xOrOList[index] = 'X';
        filledBoxes = filledBoxes + 1;
      }
      isTurnO = !isTurnO;
      checkWinner();
    });
  }

  void checkWinner() {
    if (xOrOList[0] == xOrOList[1] &&
        xOrOList[0] == xOrOList[2] &&
        xOrOList[0] != '') {
      setResult(xOrOList[0], ' برنده شد ' + xOrOList[0]);
      return;
    }
    if (xOrOList[3] == xOrOList[4] &&
        xOrOList[3] == xOrOList[5] &&
        xOrOList[3] != '') {
      setResult(xOrOList[3], ' برنده شد ' + xOrOList[3]);
      return;
    }
    if (xOrOList[6] == xOrOList[7] &&
        xOrOList[6] == xOrOList[8] &&
        xOrOList[6] != '') {
      setResult(xOrOList[6], ' برنده شد ' + xOrOList[6]);
      return;
    }
    if (xOrOList[0] == xOrOList[4] &&
        xOrOList[0] == xOrOList[8] &&
        xOrOList[0] != '') {
      setResult(xOrOList[0], ' برنده شد ' + xOrOList[0]);
      return;
    }
    if (xOrOList[2] == xOrOList[4] &&
        xOrOList[2] == xOrOList[6] &&
        xOrOList[2] != '') {
      setResult(xOrOList[2], ' برنده شد ' + xOrOList[2]);
      return;
    }
    if (xOrOList[1] == xOrOList[4] &&
        xOrOList[1] == xOrOList[7] &&
        xOrOList[1] != '') {
      setResult(xOrOList[1], ' برنده شد ' + xOrOList[1]);
      return;
    }
    if (xOrOList[0] == xOrOList[3] &&
        xOrOList[0] == xOrOList[6] &&
        xOrOList[0] != '') {
      setResult(xOrOList[0], ' برنده شد ' + xOrOList[0]);
      return;
    }
    if (xOrOList[2] == xOrOList[5] &&
        xOrOList[2] == xOrOList[8] &&
        xOrOList[2] != '') {
      setResult(xOrOList[2], ' برنده شد ' + xOrOList[2]);
      return;
    }
    if (filledBoxes == 9) {
      setResult('', 'دوباره بازی کن');
    }
  }

  Widget getTurn() {
    return Text(
      isTurnO ? 'Turn O' : 'Turn X',
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  void setResult(String winner, String title) {
    setState(() {
      gameHasResult = true;
      winnerTitle = title;

      if (winner == 'X') {
        scoreX = scoreX + 1;
      } else if (winner == 'O') {
        scoreO = scoreO + 1;
      }
    });
  }

  Widget getResultButton() {
    return Visibility(
      visible: gameHasResult,
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.green, width: 2)),
          onPressed: () {
            setState(() {
              gameHasResult = false;
              clearGame();
            });
          },
          child: Text(
            '$winnerTitle',
            style: TextStyle(
                fontSize: 30, color: Colors.green, fontWeight: FontWeight.bold),
          )),
    );
  }

  void clearGame() {
    setState(() {
      for (int i = 0; i < xOrOList.length; i++) {
        xOrOList[i] = '';
      }
    });
    filledBoxes = 0;
  }

  void clearScore() {
    setState(() {
      gameHasResult = false;
      scoreO = 0;
      scoreX = 0;
    });
  }
}
