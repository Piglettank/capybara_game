import 'dart:async';

import 'package:capybara_game/clementine.dart';
import 'package:capybara_game/crocodile.dart';
import 'package:capybara_game/ground.dart';
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
  final double gravity = 100;
  final int totalGrounds = 30;

  @override
  FutureOr<void> onLoad() {
    Clementine clementine = Clementine();

    player.position = Vector2(400, size.y - 48 * 2);
    crocodile.position = Vector2(200, size.y - 48 * 2);
    clementine.position = Vector2(800, size.y - 48 * 2);

    int grounds = 0;
    double groundXPos = 0;
    while (grounds < totalGrounds) {
      final ground = Ground();
      ground.position = Vector2(groundXPos, size.y - 48);
      add(ground);
      groundXPos += 48;
      grounds++;
    }
    add(player);
    add(crocodile);
    add(clementine);
  }
}
