import 'package:flutter/material.dart';
import 'package:skyjo_scorecard/models/models.dart';

class PlayerTile extends StatelessWidget {
  final Player player;

  const PlayerTile({Key? key, required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: player.scores.isEmpty
          ? ListTile(
              title: Text(player.name),
            )
          : ListTile(
              title: Text(player.name),
              subtitle: Text(player.scores.join(', ')),
              trailing: CircleAvatar(
                child: Text(player.score.toString()),
              ),
            ),
    );
  }
}
