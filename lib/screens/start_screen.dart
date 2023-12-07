import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/screens/tic_tac_toe.dart';

void main() => runApp(MaterialApp(home: StartScreen()));

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  late TextEditingController _player1Controller;
  late TextEditingController _player2Controller;
  String dropdownValue1 = 'X';
  String dropdownValue2 = 'O';

  @override
  void initState() {
    super.initState();
    _player1Controller = TextEditingController();
    _player2Controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _player1Controller,
                decoration: InputDecoration(
                  labelText: "Nome do Jogador 1",
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
              DropdownButton<String>(
                dropdownColor: Colors.deepPurple,
                value: dropdownValue1,
                icon: Icon(Icons.arrow_downward, color: Colors.white),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.white),
                underline: Container(
                  height: 2,
                  color: Colors.white,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue1 = newValue!;
                    dropdownValue2 = dropdownValue1 == 'X' ? 'O' : 'X';
                  });
                },
                items: <String>['X', 'O']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _player2Controller,
                decoration: InputDecoration(
                  labelText: "Nome do Jogador 2",
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
              DropdownButton<String>(
                dropdownColor: Colors.deepPurple,
                value: dropdownValue2,
                icon: Icon(Icons.arrow_downward, color: Colors.white),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.white),
                underline: Container(
                  height: 2,
                  color: Colors.white,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue2 = newValue!;
                    dropdownValue1 = dropdownValue2 == 'X' ? 'O' : 'X';
                  });
                },
                items: <String>['X', 'O']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TicTacToe(
                        player1: _player1Controller.text,
                        player2: _player2Controller.text,
                        startPlayer: dropdownValue1,
                      ),
                    ),
                  );
                },
                child: Text('Jogar'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
