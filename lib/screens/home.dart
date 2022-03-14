import 'package:flutter/material.dart';
import 'package:skyjo_scorecard/models/models.dart';
import 'package:skyjo_scorecard/widgets/widgets.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _nameInputController = TextEditingController();
  Game game = Game();

  //SAVES ME DOING IT EVERY TIME
  // void initState() {
  //   game.addPlayer("Tim");
  //   game.addPlayer("Kate");
  //   //game.start();
  //   game.players[0].score = 90;
  //   game.players[0].scores.addAll([10, 10, 10, 10, 10, 10, 10, 10, 10]);
  //   game.players[1].score = 86;
  //   game.players[1].scores.addAll([10, 10, 10, 10, 10, 10, 10, 6]);

  //   game.status = Status.started;
  //   super.initState();
  // }

  final snackBar = const SnackBar(
    content: Text('Game over!'),
  );

  Future<void> _displayScoreInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Add Scores'),
            content: SizedBox(
              width: 300,
              //height: 500,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: game.players.length,
                    itemBuilder: (BuildContext context, int index) {
                      return PlayerScoreTile(player: game.players[index]);
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              TextButton(
                child: const Text('SAVE'),
                onPressed: () {
                  setState(() {
                    game.updateScores();
                    if (game.checkEndGame()) {
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      game.status = Status.ended;
                      Navigator.of(context).pop();
                      _displayWinnerDialog(context);
                    } else {
                      Navigator.pop(context);
                    }
                  });
                },
              ),
            ],
          );
        });
  }

  Future<void> _displayWinnerDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Winner!'),
            content: SizedBox(
              width: 300,
              //height: 500,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: game.sortedPlayers.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(game.sortedPlayers[index].name),
                        trailing:
                            Text(game.sortedPlayers[index].score.toString()),
                      );
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text('OKAY'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }

  Future<void> _displayErrorDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Opps'),
            content: const Text('Need at least two players!'),
            actions: [
              TextButton(
                child: const Text('OKAY'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }

  Future<void> _displayNameInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Add Player'),
            content: TextField(
              controller: _nameInputController,
              decoration: const InputDecoration(hintText: 'Write a name...'),
            ),
            actions: [
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              TextButton(
                child: const Text('ADD'),
                onPressed: () {
                  if (_nameInputController.text != "") {
                    setState(() {
                      game.addPlayer(_nameInputController.text);
                      _nameInputController.clear();
                      Navigator.pop(context);
                    });
                  }
                },
              ),
            ],
          );
        });
  }

  _buildButton(BuildContext context) {
    switch (game.status) {
      case Status.setup:
        return TextButton(
          child: const Text(
            'START',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            setState(() {
              if (game.players.length < 2) {
                _displayErrorDialog(context);
              } else {
                game.reset();
                game.addFirstScore();
                game.status = Status.started;
              }
            });
          },
        );

      case Status.started:
        return;

      case Status.ended:
        return TextButton(
          child: const Text(
            'NEW',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            setState(() {
              game.status = Status.setup;
              game.clear();
            });
          },
        );
    }
  }

  _buildFAB(BuildContext context) {
    switch (game.status) {
      case Status.setup:
        return FloatingActionButton.extended(
          onPressed: () {
            _displayNameInputDialog(context);
          },
          icon: const Icon(Icons.add),
          label: const Text('Add Player'),
        );

      case Status.started:
        return FloatingActionButton.extended(
          onPressed: () {
            _displayScoreInputDialog(context);
          },
          icon: const Icon(Icons.add),
          label: const Text('Add Scores'),
        );

      case Status.ended:
        return FloatingActionButton.extended(
          onPressed: () {
            setState(() {
              game.reset();
              game.addFirstScore();
              game.status = Status.started;
            });
          },
          icon: const Icon(Icons.refresh),
          label: const Text('Restart'),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skyjo Scorecard'),
        actions: [
          SizedBox(
            width: 100,
            child: _buildButton(context),
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: game.players.length,
          itemBuilder: (BuildContext context, int index) {
            return PlayerTile(player: game.players[index]);
          }),
      floatingActionButton: _buildFAB(context),
    );
  }
}
