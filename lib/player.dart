import 'dart:async';

import 'package:capybara_game/clementine.dart';
import 'package:capybara_game/crocodile.dart';
import 'package:capybara_game/ground.dart';
import 'package:capybara_game/main.dart';
import 'package:capybara_game/obstacle.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class Player extends SpriteAnimationComponent
    with KeyboardHandler, HasGameReference<CapybaraGame>, CollisionCallbacks {
  Vector2 velocity = Vector2.zero();
  double speed = 50;
  double jumpForce = 500;
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
    if (other is Ground) {
      isGrounded = true;
      velocity = Vector2(velocity.x, 0);
    }
    if (other is Crocodile) {
      print('YOU LOSE! ! ! ! !');
      game.remove(other);
    }
    if (other is Clementine) {
      game.crocodile.add(
        MoveByEffect(
          Vector2(-30, 0),
          EffectController(duration: 1, curve: Curves.easeInOut),
        ),
      );
      game.remove(other);
    }
    if (other is Obstacle) {
      game.crocodile.add(
        MoveByEffect(
          Vector2(30, 0),
          EffectController(duration: 1, curve: Curves.easeInOut),
        ),
      );
      game.remove(other);
    }
  }
}
