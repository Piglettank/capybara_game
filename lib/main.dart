import 'dart:async';

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
  final Ground ground = Ground();
  final double gravity = 100;

  @override
  FutureOr<void> onLoad() {
    player.position = Vector2(100, size.y * 0.70);
    ground.position = Vector2(0, size.y * 0.80);
    debugMode = true;
    add(player);
    add(ground);
  }
}
