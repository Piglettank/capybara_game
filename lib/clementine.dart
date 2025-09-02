import 'dart:async';

import 'package:capybara_game/main.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';

class Clementine extends SpriteComponent
    with HasGameReference<CapybaraGame>, CollisionCallbacks {
  Clementine() : super(size: Vector2(48, 48), children: [CircleHitbox()]);

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    final image = await Flame.images.load('egg.jpg');
    sprite = Sprite(image, srcSize: Vector2(48, 48));
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= game.gameSpeed * dt;
  }
}
