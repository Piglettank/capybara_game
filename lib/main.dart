import 'dart:async';
import 'dart:math';

import 'package:capybara_game/clementine.dart';
import 'package:capybara_game/crocodile.dart';
import 'package:capybara_game/ground.dart';
import 'package:capybara_game/obstacle.dart';
import 'package:capybara_game/player.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(GameWidget(game: CapybaraGame()));
}

class CapybaraGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  final Player player = Player();
  final Crocodile crocodile = Crocodile();
  final double gameSpeed = 200;
  final Ground ground = Ground();
  final double gravity = 900;
  final int totalGrounds = 30;
  late Timer obstacleTimer;
  late Timer clementineTimer;
  late double commonYPos;

  @override
  FutureOr<void> onLoad() {
    commonYPos = size.y - 48 * 2;

    player.position = Vector2(400, commonYPos);
    crocodile.position = Vector2(200, commonYPos);
    obstacleTimer = Timer(Duration(seconds: 5), _spawnObstacle);
    clementineTimer = Timer(Duration(seconds: 1), _spawnClementine);

    int grounds = 0;
    double groundXPos = 0;
    while (grounds < totalGrounds) {
      final ground = Ground();
      ground.position = Vector2(groundXPos, commonYPos + 48);
      add(ground);
      groundXPos += 48;
      grounds++;
    }
    add(player);
    add(crocodile);
  }

  void _spawnClementine() {
    Clementine obstacle = Clementine();
    obstacle.position = Vector2(size.x + 48, commonYPos);
    add(obstacle);
    final newDuration = Random().nextDouble() * 5 + 1;
    obstacleTimer = Timer(
      Duration(seconds: newDuration.round()),
      _spawnClementine,
    );
  }

  void _spawnObstacle() {
    Obstacle obstacle = Obstacle();
    obstacle.position = Vector2(size.x + 48, commonYPos);
    add(obstacle);
    final newDuration = Random().nextDouble() * 5 + 1;
    obstacleTimer = Timer(
      Duration(seconds: newDuration.round()),
      _spawnObstacle,
    );
  }
}
