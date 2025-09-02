import 'dart:async';

import 'package:capybara_game/ground.dart';
import 'package:capybara_game/main.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Crocodile extends SpriteAnimationComponent
    with KeyboardHandler, HasGameReference<CapybaraGame>, CollisionCallbacks {
  Vector2 velocity = Vector2.zero();
  Crocodile() : super(size: Vector2(50, 50), children: [RectangleHitbox()]);

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    final runAnimation = await game.loadSpriteAnimation(
      'walk.png',
      SpriteAnimationData.sequenced(
        amount: 5,
        stepTime: .3,
        textureSize: Vector2.all(28),
      ),
    );

    super.animation = runAnimation;
    flipHorizontally();
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    print('collision');
    if (other is Ground) {
      velocity = Vector2(velocity.x, 0);
    }
  }
}
