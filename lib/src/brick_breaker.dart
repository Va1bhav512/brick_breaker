import 'dart:async';
import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/components.dart';
import 'config.dart';

enum PlayState { welcome, playing, gameOver, won }

class BrickBreaker extends FlameGame
    with HasCollisionDetection, KeyboardEvents, TapDetector {
  BrickBreaker()
      : super(
          camera: CameraComponent.withFixedResolution(
            width: gameWidth,
            height: gameHeight,
          ),
        );
  
  final ValueNotifier<int> score = ValueNotifier(0);
  final rand = math.Random();
  double get width => size.x;
  double get height => size.y;

  late PlayState _playState;
  PlayState get playState => _playState;
  set playState(PlayState playState) {
    _playState = playState;
    switch (playState) {
      case PlayState.welcome:
      case PlayState.gameOver:
      case PlayState.won:
        overlays.add(playState.name);
      case PlayState.playing:
        overlays.remove(PlayState.welcome.name);
        overlays.remove(PlayState.gameOver.name);
        overlays.remove(PlayState.won.name);
    }
  }

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    camera.viewfinder.anchor = Anchor.topLeft;

    world.add(PlayArea());

    playState = PlayState.welcome;
  }

  void startGame() {
    if (playState == PlayState.playing) return;

    world.removeAll(world.children.query<Ball>());
    world.removeAll(world.children.query<Bat>());
    world.removeAll(world.children.query<Brick>());
    playState = PlayState.playing;
    score.value = 0;

    world.add(Ball(
        difficultyModifier: difficultyModifier,
        velocity: Vector2((rand.nextDouble() - 0.5) * width, height * 0.20)
            .normalized()
          ..scale(height / 4),
        position: size / 2,
        radius: ballRadius));

    world.add(Bat(
        size: Vector2(batWidth, batHeight),
        cornerRadius: const Radius.circular(ballRadius / 2),
        position: Vector2(width / 2, height * 0.95)));

    world.addAll([
      for (var i = 0; i < brickColors.length; i++)
        for (var j = 0; j <= 5; j++)
          Brick(
            position: Vector2(
              (i + 0.5) * brickWidth + (i + 1) * brickGutter,
              (j + 2.0) * brickHeight + j * brickGutter,
            ),
            color: brickColors[i],
          ),
    ]);
  }

  @override
  void onTap() {
    super.onTap();
    startGame();
  }

  bool isMovingLeft = false;
  bool isMovingRight = false;
  @override
  void update(double dt) {
    super.update(dt);

    batAcceleration += 0.5 * dt; // Increment acceleration over time
    // Handle acceleration
    if (isMovingLeft) {
      world.children
          .query<Bat>()
          .first
          .moveBy(-batSpeed * dt * batAcceleration);
    } else if (isMovingRight) {
      world.children.query<Bat>().first.moveBy(batSpeed * dt * batAcceleration);
    } else {
      // Decelerate or reset acceleration when no key is pressed
      batAcceleration = 1.0;
    }
  }

  @override
  KeyEventResult onKeyEvent(
      KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    super.onKeyEvent(event, keysPressed);

    // Reset acceleration when key press is detected
    if (event is KeyDownEvent) {
      switch (event.logicalKey) {
        case LogicalKeyboardKey.arrowLeft:
        case LogicalKeyboardKey.keyA:
          isMovingLeft = true;
          isMovingRight = false;
          break;
        case LogicalKeyboardKey.arrowRight:
        case LogicalKeyboardKey.keyD:
          isMovingRight = true;
          isMovingLeft = false;
          break;
        case LogicalKeyboardKey.space:
        case LogicalKeyboardKey.enter:
          startGame();
      }
    } else if (event is KeyUpEvent) {
      // Reset movement when key is released
      if (event.logicalKey == LogicalKeyboardKey.arrowLeft ||
          event.logicalKey == LogicalKeyboardKey.keyA) {
        isMovingLeft = false;
      }
      if (event.logicalKey == LogicalKeyboardKey.arrowRight ||
          event.logicalKey == LogicalKeyboardKey.keyD) {
        isMovingRight = false;
      }
    }
    return KeyEventResult.handled;
  }

  @override
  Color backgroundColor() => const Color(0xfff2e8cf);
}
