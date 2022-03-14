import 'package:flutter/material.dart';
import 'package:holding_gesture/holding_gesture.dart';
import 'package:skyjo_scorecard/models/models.dart';

class PlayerScoreTile extends StatefulWidget {
  final Player player;
  const PlayerScoreTile({Key? key, required this.player}) : super(key: key);

  @override
  _PlayerScoreTileState createState() => _PlayerScoreTileState();
}

class _PlayerScoreTileState extends State<PlayerScoreTile> {
  void _minusScore() {
    setState(() {
      widget.player.roundScore -= 1;
    });
  }

  void _addScore() {
    setState(() {
      widget.player.roundScore += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.player.name),
      tileColor: widget.player.roundFirst ? Colors.blue : Colors.white,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          HoldDetector(
            child: Container(
              height: 25,
              width: 25,
              color: Colors.grey,
              child: const Center(
                child: Text(
                  '-',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            onHold: _minusScore,
            //test on phone
            enableHapticFeedback: true,
            holdTimeout: const Duration(milliseconds: 100),
          ),
          const SizedBox(
            width: 10,
          ),
          CircleAvatar(
            child: Text(widget.player.roundScore.toString()),
          ),
          const SizedBox(
            width: 10,
          ),
          HoldDetector(
            child: Container(
              height: 25,
              width: 25,
              color: Colors.grey,
              child: const Center(
                child: Text(
                  '+',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            onHold: _addScore,
            //test on phone
            enableHapticFeedback: true,
            holdTimeout: const Duration(milliseconds: 100),
          ),
        ],
      ),
    );
  }
}
