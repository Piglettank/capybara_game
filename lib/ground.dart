import 'dart:async';

import 'package:capybara_game/main.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';

class Ground extends SpriteComponent
    with HasGameReference<CapybaraGame>, CollisionCallbacks {
  Ground() : super(size: Vector2(2000, 100), children: [RectangleHitbox()]);

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    final image = await Flame.images.load('egg.jpg');
    sprite = Sprite(image);
  }
}
