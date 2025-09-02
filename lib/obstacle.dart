import 'dart:async';

import 'package:capybara_game/main.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';

class Obstacle extends SpriteComponent
    with HasGameReference<CapybaraGame>, CollisionCallbacks {
  Obstacle() : super(size: Vector2(50, 50), children: [RectangleHitbox()]);

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    final image = await Flame.images.load('egg.jpg');
    sprite = Sprite(image);
  }

  @override
  void update(double dt) {
    position.x -= game.gameSpeed * dt;
    if (position.x < -size.x) {
      position.x = game.totalGrounds * size.x + position.x;
    }
    super.update(dt);
  }
}
