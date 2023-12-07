import 'package:flutter/material.dart';

class TicTacToe extends StatefulWidget {
  final String player1;
  final String player2;
  final String startPlayer;

  TicTacToe(
      {required this.player1,
      required this.player2,
      required this.startPlayer});

  @override
  _TicTacToeState createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  late List<List<String>> _matrix;
  String _lastChar = 'O';
  String _gameState = '';

  @override
  void initState() {
    super.initState();
    _matrix = List<List<String>>.generate(3, (_) => List<String>.filled(3, ''));
    _lastChar = widget.startPlayer;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(
        title: Center(
            child: Text('Jogo da Velha',
                style: TextStyle(fontSize: 24, color: Colors.white))),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.purple, Colors.blue],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(10.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: 9,
                itemBuilder: (context, index) => _buildItem(index),
              ),
            ),
            Text(_gameState,
                style: TextStyle(fontSize: 24, color: Colors.white)),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _resetGame,
              child: Text('Resetar Jogo', style: TextStyle(fontSize: 20)),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
            ),
            SizedBox(height: 150),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(int index) {
    int rowIndex = index ~/ 3;
    int colIndex = index % 3;
    return GestureDetector(
      onTap: () {
        _changeMatrix(rowIndex, colIndex);
        _checkWinner(rowIndex, colIndex);
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(
            color: Colors.grey.shade700,
          ),
        ),
        child: Center(
          child: Text(
            _matrix[rowIndex][colIndex],
            style: TextStyle(
              fontSize: 92.0,
              color: Colors.white,
              shadows: <Shadow>[
                Shadow(
                  offset: Offset(2.0, 2.0),
                  blurRadius: 3.0,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                Shadow(
                  offset: Offset(2.0, 2.0),
                  blurRadius: 8.0,
                  color: Color.fromARGB(125, 0, 0, 255),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _changeMatrix(int x, int y) {
    setState(() {
      if (_matrix[x][y] == '') {
        if (_lastChar == 'O')
          _matrix[x][y] = 'X';
        else
          _matrix[x][y] = 'O';
        _lastChar = _matrix[x][y];
      }
    });
  }

  _checkWinner(int x, int y) {
    var col = 0, row = 0, diag = 0, rdiag = 0;
    var n = _matrix.length - 1;
    var player = _matrix[x][y];

    for (int i = 0; i < _matrix.length; i++) {
      if (_matrix[x][i] == player) col++;
      if (_matrix[i][y] == player) row++;
      if (_matrix[i][i] == player) diag++;
      if (_matrix[i][n - i] == player) rdiag++;
    }

    if (row == n + 1 || col == n + 1 || diag == n + 1 || rdiag == n + 1) {
      setState(() {
        if (player == 'X') {
          _gameState = '${widget.player1} ganhou';
        } else {
          _gameState = '${widget.player2} ganhou';
        }
      });
    } else if (!_matrix.expand((i) => i).contains('')) {
      setState(() {
        _gameState = '${widget.player1} e ${widget.player2} empataram';
      });
    }
  }

  _resetGame() {
    setState(() {
      _matrix =
          List<List<String>>.generate(3, (_) => List<String>.filled(3, ''));
      _gameState = '';
      _lastChar = 'O';
    });
  }
}
