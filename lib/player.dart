import 'dart:async';

import 'package:capybara_game/ground.dart';
import 'package:capybara_game/main.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';

class Player extends SpriteAnimationComponent
    with KeyboardHandler, HasGameReference<CapybaraGame>, CollisionCallbacks {
  Vector2 velocity = Vector2.zero();
  double speed = 50;
  double jumpForce = 100;
  double startingYPosition = 0;
  bool isGrounded = false;
  Player() : super(size: Vector2(50, 50), children: [RectangleHitbox()]);

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
    startingYPosition = position.y;
    flipHorizontally();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!isGrounded) {
      velocity.y += game.gravity * dt;
    }

    position.add(velocity * dt);
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    // if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
    //   velocity = Vector2(speed, velocity.y);
    // }
    // if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
    //   velocity = Vector2(-speed, velocity.y);
    // }
    if (keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
      if (isGrounded) {
        isGrounded = false;
        velocity = Vector2(velocity.x, -jumpForce);
      }
    }
    return super.onKeyEvent(event, keysPressed);
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    print('collision');
    if (other is Ground) {
      isGrounded = true;
      velocity = Vector2(velocity.x, 0);
    }
  }
}
