import 'models.dart';

enum Status {
  setup,
  started,
  ended,
}

class Game {
  List<Player> players = [];
  List<Player> sortedPlayers = [];
  Status status = Status.setup;

  Game();

  void addPlayer(String name) {
    players.add(Player(name: name));
  }

  void updateScores() {
    for (var player in players) {
      player.scores.add(player.roundScore);
      player.score += player.roundScore;
      player.roundScore = 0;
      player.roundFirst = false;
    }
  }

  void addFirstScore() {
    for (var player in players) {
      player.scores.add(0);
    }
  }

  void reset() {
    for (var player in players) {
      player.roundScore = 0;
      player.score = 0;
      player.scores = [];
      player.roundFirst = false;
    }
  }

  void clear() {
    players = [];
    sortedPlayers = [];
  }

  checkEndGame() {
    sortedPlayers = [];
    sortedPlayers.addAll(players);
    sortedPlayers.sort((a, b) => a.score.compareTo(b.score));
    if (sortedPlayers[sortedPlayers.length - 1].score >= 100) {
      return true;
    }
    return false;
  }
}
