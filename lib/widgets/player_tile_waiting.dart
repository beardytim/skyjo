import 'package:flutter/material.dart';
import 'package:skyjo_scorecard/models/models.dart';

class PlayerTileWaiting extends StatelessWidget {
  final Player player;
  const PlayerTileWaiting({Key? key, required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(title: Text(player.name)),
    );
  }
}
