import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  bool isX = true;
  List<String> displayXO = [
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
  ];
  List<int> selectedIndex = [];
  int xCount = 0;
  int oCount = 0;
  int tieCount = 0;
  String resultDeclaration = "";

  bool isReset = false;

  static const int max_seconds = 30;
  int seconds = max_seconds;

  Timer? timer;

  void _onTap(int index) {
    final isRunning = timer != null && timer!.isActive;

    if (isRunning) {
      setState(() {
        if (isX && displayXO[index] == " ") {
          displayXO[index] = "O";
          tieCount++;
        } else if (!isX && displayXO[index] == " ") {
          displayXO[index] = "X";
          tieCount++;
        }
        isX = !isX;

        _checkWin();
      });
    }
  }

  void _checkWin() {
    if (displayXO[0] == displayXO[1] &&
        displayXO[0] == displayXO[2] &&
        displayXO[0] != " ") {
      setState(() {
        resultDeclaration = "Player " + displayXO[0] + " Wins";
        selectedIndex.addAll([0, 1, 2]);
        _stopTimer();
        _updateScore(displayXO[0]);
      });
    }
    if (displayXO[3] == displayXO[4] &&
        displayXO[3] == displayXO[5] &&
        displayXO[3] != " ") {
      setState(() {
        resultDeclaration = "Player " + displayXO[3] + " Wins";
        selectedIndex.addAll([3, 4, 5]);
        _stopTimer();
        _updateScore(displayXO[3]);
      });
    }
    if (displayXO[6] == displayXO[7] &&
        displayXO[6] == displayXO[8] &&
        displayXO[6] != " ") {
      setState(() {
        resultDeclaration = "Player " + displayXO[6] + " Wins";
        selectedIndex.addAll([6, 7, 8]);
        _stopTimer();
        _updateScore(displayXO[6]);
      });
    }
    if (displayXO[0] == displayXO[3] &&
        displayXO[0] == displayXO[6] &&
        displayXO[0] != " ") {
      setState(() {
        resultDeclaration = "Player " + displayXO[0] + " Wins";
        selectedIndex.addAll([0, 3, 6]);
        _stopTimer();
        _updateScore(displayXO[0]);
      });
    }
    if (displayXO[1] == displayXO[4] &&
        displayXO[1] == displayXO[7] &&
        displayXO[1] != " ") {
      setState(() {
        resultDeclaration = "Player " + displayXO[1] + " Wins";
        selectedIndex.addAll([1, 4, 7]);
        _stopTimer();
        _updateScore(displayXO[1]);
      });
    }
    if (displayXO[2] == displayXO[5] &&
        displayXO[2] == displayXO[8] &&
        displayXO[2] != " ") {
      setState(() {
        resultDeclaration = "Player " + displayXO[2] + " Wins";
        selectedIndex.addAll([2, 5, 8]);
        _stopTimer();
        _updateScore(displayXO[2]);
      });
    }

    //DAIGONAL
    if (displayXO[0] == displayXO[4] &&
        displayXO[0] == displayXO[8] &&
        displayXO[0] != " ") {
      setState(() {
        resultDeclaration = "Player " + displayXO[0] + " Wins";
        selectedIndex.addAll([0, 4, 8]);
        _stopTimer();
        _updateScore(displayXO[0]);
      });
    }
    if (displayXO[2] == displayXO[4] &&
        displayXO[2] == displayXO[6] &&
        displayXO[2] != " ") {
      setState(() {
        resultDeclaration = "Player " + displayXO[0] + " Wins";
        selectedIndex.addAll([2, 4, 6]);
        _stopTimer();
        _updateScore(displayXO[0]);
      });
    }
    if (displayXO[0] == displayXO[4] &&
        displayXO[0] == displayXO[8] &&
        displayXO[0] != " ") {
      setState(() {
        resultDeclaration = "Player " + displayXO[0] + " Wins";
        selectedIndex.addAll([0, 4, 8]);
        _stopTimer();
        _updateScore(displayXO[0]);
      });
    }
    if (!isReset && tieCount == 9) {
      setState(() {
        resultDeclaration = "TIE!";
      });
    }
  }

  void _updateScore(String player) {
    setState(() {
      if (player == "X") {
        xCount++;
      } else if (player == "O") {
        oCount++;
        isReset = true;
      }
    });
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayXO[i] = " ";
      }
      resultDeclaration = "";
    });
    tieCount = 0;
  }

  Widget _buildTimer() {
    final isRunning = timer != null && timer!.isActive;
    return isRunning
        ? SizedBox(
            width: 100,
            height: 100,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: 1 - seconds / max_seconds,
                  backgroundColor: Colors.pink[100],
                  strokeWidth: 8,
                  valueColor: AlwaysStoppedAnimation(Colors.pink[900]!),
                ),
                Center(
                  child: Text(
                    '$seconds',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink[900],
                    ),
                  ),
                ),
              ],
            ),
          )
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink[200],
              foregroundColor: Colors.black,
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 10),
            ),
            onPressed: () {
              _startTimer();
              _clearBoard();
            },
            child: Text(
              "Start",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          );
  }

  void _startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          _resetTimer();
        }
      });
    });
  }

  void _stopTimer() {
    _resetTimer();
    timer?.cancel();
  }

  void _resetTimer() => seconds = max_seconds;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.pink,
        appBar: AppBar(
          title: Text("Tic Tac Toe",
              style: TextStyle(
                  fontFamily: "Pacifico",
                  fontSize: 30,
                  fontWeight: FontWeight.bold)),
          leading: Icon(Icons.person),
          centerTitle: true,
          backgroundColor: Colors.pink,
        ),
        body: Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    "Sorce Board",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: GridView.builder(
                    itemCount: 9,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          onTap: () {
                            _onTap(index);

                            print("Tapped");
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 5,
                                color: Color.fromARGB(255, 13, 1, 5),
                              ),
                              color: selectedIndex.contains(index)
                                  ? const Color.fromARGB(255, 208, 111, 143)!
                                  : Colors.pink[100]!,
                            ),
                            child: Center(
                              child: Text(
                                displayXO[index],
                                style: TextStyle(
                                    fontSize: 50, color: Colors.pink[900]),
                              ),
                            ),
                          ));
                    }),
              ),
              Expanded(
                  flex: 2,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          resultDeclaration,
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        _buildTimer(),

                        // ElevatedButton(
                        //   style: ElevatedButton.styleFrom(
                        //     backgroundColor: Color.fromARGB(255, 243, 136, 175),
                        //     foregroundColor: Colors.black,
                        //     padding: EdgeInsets.symmetric(
                        //         horizontal: 32, vertical: 10),
                        //   ),
                        //   onPressed: () {
                        //     _clearBoard();
                        //   },
                        //   child: Text("Reset",
                        //       style: TextStyle(
                        //         fontSize: 20,
                        //         fontWeight: FontWeight.bold,
                        //         color: Colors.black,
                        //       )),
                        // )
                      ],
                    ),
                  )),
              Expanded(
                flex: -1,
                child: Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Player X",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          xCount.toString(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Player O",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          oCount.toString(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [],
                    )
                  ],
                )),
              ),
            ],
          ),
        ));
  }
}
