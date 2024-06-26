import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pixeladventure/src/hud/hud.dart';
import 'components/jump_button.dart';
import 'game/level.dart';
import 'game/player1.dart';

class PixelAdventure extends FlameGame
    with
        HasKeyboardHandlerComponents,
        DragCallbacks,
        HasCollisionDetection,
        TapCallbacks {

  int health = 3;
  late CameraComponent camara;
  Player1 player1 = Player1(character: 'Pink Man');
  //Player2 player2 = Player2(character: 'Mask Dude');
  late JoystickComponent joystick;
  bool showControls = false;
  bool playSounds = false;
  double soundVolume = 1.0;
  List<String> levelNames = ['Level05'];
  int currentLevelIndex = 0;
  Vector2 joystickInput = Vector2.zero();


  @override
  FutureOr<void> onLoad() async {
    //Confirmacion de que se carguen los recursos
    await super.onLoad();

    //Carga todas las imagenes del cache
    await images.loadAllImages();

    _loadLevel();

    if (showControls) {
      addJoystick();
      add(JumpButton());
    }
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (showControls) {
      updateJoystick();
    }
    player1.updateInput(joystickInput);
    return super.update(dt);
  }

  void updateJoystick() {
    joystickInput = Vector2.zero();
    switch (joystick.direction) {
      case JoystickDirection.left:
      case JoystickDirection.upLeft:
      case JoystickDirection.downLeft:
        joystickInput.x = -1;
        break;
      case JoystickDirection.right:
      case JoystickDirection.upRight:
      case JoystickDirection.downRight:
        joystickInput.x = 1;
        break;
      default:
        joystickInput.x = 0;
        break;
    }
  }

  void addJoystick() {
    joystick = JoystickComponent(
      priority: 10,
      knob: SpriteComponent(
        sprite: Sprite(
          images.fromCache('HUD/Puntero.png'),
        ),
      ),
      background: SpriteComponent(
        sprite: Sprite(
          images.fromCache('HUD/Joystick.png'),
        ),
      ),
      margin: const EdgeInsets.only(left: 32, bottom: 32),
    );
    add(joystick);
  }


  void loadNextLevel() {
    if (currentLevelIndex < levelNames.length - 1) {
      currentLevelIndex++;
      _loadLevel();
    } else {
      // no mas niveles
      currentLevelIndex = 0;
      _loadLevel();
    }
  }

  void _loadLevel() {
    Future.delayed(const Duration(seconds: 1), () async {
      Level world = Level(
        player1: player1,
       // player2: player2,
        levelName: levelNames[currentLevelIndex],
      );

      camara = CameraComponent.withFixedResolution(
        world: world,
        width: 640,
        height: 360,
      );
      camara.viewfinder.anchor = Anchor.topLeft;

      camara.viewport.add(Hud());

      addAll([camara, world]);
    });
  }
}
