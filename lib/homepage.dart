import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool osTurn = true;
  List<String> displayXO = ['', '', '', '', '', '', '', '', '',];
  var myStyle = TextStyle(color: Colors.white, fontSize: 25);
  int xScore = 0;
  int oScore = 0;
  int boxesFilled = 0;

  static var googleFont = GoogleFonts.pressStart2P(
      textStyle: TextStyle(color: Colors.black, fontSize: 15, letterSpacing: 3)
  );
  static var googleWhite = GoogleFonts.pressStart2P(
      textStyle: TextStyle(color: Colors.white,fontSize: 25, letterSpacing: 3)
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Column(
        children: <Widget>[
          Expanded(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Player X', style: googleWhite,),
                          Text(xScore.toString(), style: googleWhite,)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Player O', style: googleWhite),
                          Text(oScore.toString(), style: googleWhite,)
                        ],
                      ),
                    ),
                  ],
                ),
              )
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      tapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[700])
                      ),
                      child: Center(
                        child: Text(displayXO[index].toString(),
                          style: TextStyle(color: Colors.white, fontSize: 35),),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
              child: Container(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text('TIC TAC TOE', style: googleWhite),
                      Text('a kaar07 production', style: TextStyle(fontSize: 12,color: Colors.grey[900])),
                    ],
                  ),
                ),
              )
          ),
        ],
      ),
    );
  }

  void tapped(int index) {
    setState(() {
      if (osTurn == true && displayXO[index] == "") {
        displayXO[index] = 'o';
        boxesFilled += 1;
      } else if (osTurn == false && displayXO[index] == "") {
        displayXO[index] = 'x';
        boxesFilled += 1;
      }
      osTurn = !osTurn;
      checkWinner();
    });
  }

  void checkWinner() {
    if (displayXO[0] == displayXO[1] && displayXO[1] == displayXO[2] &&
        displayXO[0] != '') {
      declareWinner(displayXO[0]);
    }
    else if (displayXO[3] == displayXO[4] && displayXO[4] == displayXO[5] &&
        displayXO[4] != '') {
      declareWinner(displayXO[3]);
    }
    else if (displayXO[6] == displayXO[7] && displayXO[7] == displayXO[8] &&
        displayXO[7] != '') {
      declareWinner(displayXO[7]);
    }
    else if (displayXO[0] == displayXO[3] && displayXO[3] == displayXO[6] &&
        displayXO[3] != '') {
      declareWinner(displayXO[3]);
    }
    else if (displayXO[1] == displayXO[4] && displayXO[4] == displayXO[7] &&
        displayXO[4] != '') {
      declareWinner(displayXO[4]);
    }
    else if (displayXO[2] == displayXO[5] && displayXO[5] == displayXO[8] &&
        displayXO[5] != '') {
      declareWinner(displayXO[5]);
    }
    else if (displayXO[0] == displayXO[4] && displayXO[4] == displayXO[8] &&
        displayXO[4] != '') {
      declareWinner(displayXO[4]);
    }
    else if (displayXO[2] == displayXO[4] && displayXO[4] == displayXO[6] &&
        displayXO[4] != '') {
      declareWinner(displayXO[4]);
    }
    else if (boxesFilled == 9) {
      drawMessage();
    }
  }

  void declareWinner(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(winner + ' won!'),
            actions: <Widget>[
              TextButton(
                child: Text('Play Again?',
                  style: TextStyle(color: Colors.black, fontSize: 25),),
                onPressed: () {
                  clearTheBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
    if (winner == 'o') {
      oScore += 1;
      osTurn = false;
    } else if (winner == 'x') {
      xScore += 1;
      osTurn = true;
    }
  }
  void drawMessage() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Drawn"),
            actions: <Widget>[
              TextButton(
                child: Text('Play Again?',
                  style: TextStyle(color: Colors.black, fontSize: 25),),
                onPressed: () {
                  clearTheBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void clearTheBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayXO[i] = '';
      }
    });
    boxesFilled = 0;
  }
}
