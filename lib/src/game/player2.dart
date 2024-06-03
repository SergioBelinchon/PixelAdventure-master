import 'dart:async';
import 'dart:core';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/services.dart';
import 'package:pixeladventure/src/game/player1.dart';
import 'package:pixeladventure/src/game/sierra.dart';
import 'package:pixeladventure/src/pixel_adventure.dart';
import '../colisiones/custom_hitbox.dart';
import '../colisiones/utils.dart';
import 'checkpoint.dart';
import 'chicken.dart';
import '../colisiones/colision_bloque.dart';
import 'fruit.dart';

enum PlayerState { idle, running, jumping, falling, hit, appearing, disappearing }

class Player2 extends SpriteAnimationGroupComponent
    with HasGameRef<PixelAdventure>, KeyboardHandler, CollisionCallbacks {
  String character;

  Player2({
    position,
    this.character = 'Mask Dude',
  }) : super(position: position);

  final double stepTime = 0.05;

  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runningAnimation;
  late final SpriteAnimation jumpingAnimation;
  late final SpriteAnimation fallingAnimation;
  late final SpriteAnimation hitAnimation;
  late final SpriteAnimation appearingAnimation;
  late final SpriteAnimation disappearingAnimation;

  final double _gravedad = 9.8;
  final double _fuerzaSalto = 260;
  final double _terminalVelocity = 300;

  int lives = 3;
  double horizontalMovement = 0;
  double moveSpeed = 100;
  Vector2 startingPosition = Vector2.zero();
  Vector2 velocity = Vector2.zero();
  bool isEnSuelo = false;
  bool haSaltado = false;
  bool gotHit = false;
  bool reachedCheckpoint = false;
  List<ColisionBloque> colisionBloques = [];

  CustomHitbox hitbox = CustomHitbox(
    offsetX: 10,
    offsetY: 4,
    width: 14,
    height: 28,
  );

  double fixedDeltaTime = 1 / 60;
  double accumulatedTime = 0;

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    //debugMode = true;

    startingPosition = Vector2(position.x, position.y);

    add(RectangleHitbox(
      position: Vector2(hitbox.offsetX, hitbox.offsetY),
      size: Vector2(hitbox.width, hitbox.height),
    ));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    accumulatedTime += dt;

    while (accumulatedTime >= fixedDeltaTime) {
      if (!gotHit && !reachedCheckpoint) {
        _updatePlayerState();
        _updatePlayerMovement(fixedDeltaTime);
        _checkHorizontalColisiones();
        _aplicarGravedad(fixedDeltaTime);
        _checkVerticalColisiones();
      }
      accumulatedTime -= fixedDeltaTime;
    }

    super.update(dt);
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    horizontalMovement = 0;
    final isLeftKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyA);
    final isRightKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyD);

    horizontalMovement += isLeftKeyPressed ? -1 : 0;
    horizontalMovement += isRightKeyPressed ? 1 : 0;

    haSaltado = keysPressed.contains(LogicalKeyboardKey.keyS);

    return super.onKeyEvent(event, keysPressed);
  }


  @override
  void onCollisionStart(Set<Vector2> intersectionPoints,
      PositionComponent other) {
    if (!reachedCheckpoint) {
      if (other is Fruit) other.collidedWithPlayer();
      if (other is Sierra) _respawn();
      if (other is Chicken) other.collidedWithPlayer2();
      if (other is Checkpoint) _reachedCheckpoint();
      if (other is Player1) other.collidedWithPlayer2();
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  void _loadAllAnimations() {
    idleAnimation = _spriteAnimation('Idle', 11);
    runningAnimation = _spriteAnimation('Run', 12);
    jumpingAnimation = _spriteAnimation('Jump', 1);
    fallingAnimation = _spriteAnimation('Fall', 1);
    hitAnimation = _spriteAnimation('Hit', 7)
      ..loop = false;
    appearingAnimation = _specialSpriteAnimation('Appearing', 7);
    disappearingAnimation = _specialSpriteAnimation('Disappearing', 7);


    //Lista de animaciones
    animations = {
      PlayerState.idle: idleAnimation,
      PlayerState.running: runningAnimation,
      PlayerState.jumping: jumpingAnimation,
      PlayerState.falling: fallingAnimation,
      PlayerState.hit: hitAnimation,
      PlayerState.appearing: appearingAnimation,
      PlayerState.disappearing: disappearingAnimation,


    };
    //Set animacion
    current = PlayerState.running;
  }

  SpriteAnimation _spriteAnimation(String state, int amount) {
    return SpriteAnimation.fromFrameData(
      game.images.fromCache('Main Characters/$character/$state (32x32).png'),
      SpriteAnimationData.sequenced(
        amount: amount,
        stepTime: stepTime,
        textureSize: Vector2.all(32),
      ),
    );
  }

  SpriteAnimation _specialSpriteAnimation(String state, int amount) {
    return SpriteAnimation.fromFrameData(
      game.images.fromCache('Main Characters/$state (96x96).png'),
      SpriteAnimationData.sequenced(
        amount: amount,
        stepTime: stepTime,
        textureSize: Vector2.all(96),
        loop: false,
      ),
    );
  }

  void _updatePlayerState() {
    PlayerState playerState = PlayerState.idle;

    if (velocity.x < 0 && scale.x > 0) {
      flipHorizontallyAroundCenter();
    }
    else if (velocity.x > 0 && scale.x < 0) {
      flipHorizontallyAroundCenter();
    }

    //Si se mueve, corre
    if (velocity.x > 0 || velocity.x < 0) playerState = PlayerState.running;

    //Si cae, mostrar que cae
    if (velocity.y > 0) playerState = PlayerState.falling;

    //Si salta, mostrar que salta
    if (velocity.y < 0) playerState = PlayerState.jumping;

    current = playerState;
  }

  void _updatePlayerMovement(double dt) {
    if (haSaltado && isEnSuelo) _playerSalto(dt);

    //if(velocity.y > _gravedad) isEnSuelo = false; //Opcional

    velocity.x = horizontalMovement * moveSpeed;
    position.x += velocity.x * dt;
  }

  void _playerSalto(double dt) {
    if (game.playSounds) FlameAudio.play('jump.wav', volume: game.soundVolume);
    velocity.y = -_fuerzaSalto;
    position.y += velocity.y * dt;
    isEnSuelo = false;
    haSaltado = false;
  }

  void _checkHorizontalColisiones() {
    for (final bloque in colisionBloques) {
      if (!bloque.isPlataforma) {
        if (checkColision(this, bloque)) {
          if (velocity.x > 0) {
            velocity.x = 0;
            position.x = bloque.x - hitbox.offsetX - hitbox.width;
            break;
          }
          if (velocity.x < 0) {
            velocity.x = 0;
            position.x =
                bloque.x + bloque.width + hitbox.width + hitbox.offsetX;
            break;
          }
        }
      }
    }
  }

  void _aplicarGravedad(double dt) {
    velocity.y += _gravedad;
    velocity.y = velocity.y.clamp(-_fuerzaSalto, _terminalVelocity);
    position.y += velocity.y * dt;
  }

  void _checkVerticalColisiones() {
    for (final bloque in colisionBloques) {
      if (bloque.isPlataforma) {
        if (checkColision(this, bloque)) {
          if (velocity.y > 0) {
            velocity.y = 0;
            position.y = bloque.y - hitbox.height - hitbox.offsetY;
            isEnSuelo = true;
            break;
          }
        }
      }
      else {
        if (checkColision(this, bloque)) {
          if (velocity.y > 0) {
            velocity.y = 0;
            position.y = bloque.y - hitbox.height - hitbox.offsetY;
            isEnSuelo = true;
            break;
          }
          if (velocity.y < 0) {
            velocity.y = 0;
            position.y = bloque.y + bloque.height - hitbox.offsetY;
          }
        }
      }
    }
  }

  void _respawn() async
  {
    if (game.playSounds) {
      FlameAudio.play('bruh.wav', volume: game.soundVolume);
    }

    const canMoveDuration = Duration(milliseconds: 400);

    gotHit = true;
    current = PlayerState.hit;

    await animationTicker?.completed;
    animationTicker?.reset();

    scale.x = 1;
    position = startingPosition - Vector2.all(32);
    current = PlayerState.appearing;

    await animationTicker?.completed;
    animationTicker?.reset();

    velocity = Vector2.zero();
    position = startingPosition;
    _updatePlayerState();
    Future.delayed(canMoveDuration, () => gotHit = false);
  }


  void _reachedCheckpoint() async
  {
    reachedCheckpoint = true;
    if (game.playSounds) {
      FlameAudio.play('level_completed.wav', volume: game.soundVolume);
    }
    if (scale.x > 0) {
      position = position - Vector2.all(32);
    }
    else if (scale.x < 0) {
      position = position + Vector2(32, -32);
    }
    current = PlayerState.disappearing;

    await animationTicker?.completed;
    animationTicker?.reset();

    reachedCheckpoint = false;
    position = Vector2.all(-600);

    const waitToChangeDuration = Duration(seconds: 3);
    Future.delayed(waitToChangeDuration,
            () =>
            game.loadNextLevel());
  }


  void collidedWithEnemy() {
    _respawn();
  }

  void collidedWithPlayer1() {
    _respawn();
  }
}

