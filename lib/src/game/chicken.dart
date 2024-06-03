import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:pixeladventure/src/game/player1.dart';
import 'package:pixeladventure/src/game/player2.dart';
import 'package:pixeladventure/src/pixel_adventure.dart';

enum State { idle, run, hit }

class Chicken extends SpriteAnimationGroupComponent
with HasGameRef<PixelAdventure>, CollisionCallbacks
{
  final double offNeg;
  final double offPos;

  Chicken({super.position,
    super.size,
    this.offNeg = 0,
    this.offPos = 0,
  });

  static const stepTime = 0.05;
  static const tileSize = 16;
  static const runSpeed = 80;
  static const _bounceHeight= 260.0;
  final textureSize = Vector2(32, 34);

  Vector2 velocity = Vector2.zero();
  double rangeNeg = 0;
  double rangePos = 0;
  double moveDirection = 1;
  double targetDirection = -1;
  bool gotStomped = false;


  late final Player1 player1;
  late final Player2 player2;
  late final SpriteAnimation _idleAnimation;
  late final SpriteAnimation _hitAnimation;
  late final SpriteAnimation _runAnimation;

  @override
  FutureOr<void> onLoad()
  {
    //debugMode = true;
    player1 = game.player1;
    player2 = game.player2;

    add(
      RectangleHitbox(
        position: Vector2(4, 6),
        size: Vector2(24, 26),
      ),
    );
    _loadAllAnimations();
    _calculateRange();
    return super.onLoad();
  }

  @override
  void update(double dt)
  {
    if(!gotStomped)
      {
        _updateState();
        _movement(dt);
      }

    super.update(dt);
  }

  void _loadAllAnimations()
  {
    _idleAnimation = _spriteAnimation('Idle', 13);
    _runAnimation = _spriteAnimation('Run', 14);
    _hitAnimation = _spriteAnimation('Hit', 15)..loop = false;

    animations =
        {
          State.idle : _idleAnimation,
          State.run : _runAnimation,
          State.hit : _hitAnimation,
        };
    current = State.idle;
  }

  SpriteAnimation _spriteAnimation(String state, int amount)
  {
    return SpriteAnimation.fromFrameData(game.images.fromCache('Enemies/Chicken/$state (32x34).png'),
        SpriteAnimationData.sequenced(
            amount: amount,
            stepTime: stepTime,
            textureSize: textureSize,
        ),
    );
  }

  void _calculateRange()
  {
    rangeNeg = position.x - offNeg * tileSize;
    rangePos = position.x + offPos * tileSize;

  }

  void _movement(dt)
  {
    velocity.x = 0;

    double player1Offset = (player1.scale.x > 0) ? 0 : -player1.width;
    double player2Offset = (player2.scale.x > 0) ? 0 : -player2.width;
    double chickenOffset = (scale.x > 0) ? 0 : -width;

    if(player1InRange())
      {
        targetDirection =
        (player1.x + player1Offset < position.x + chickenOffset) ? -1 : 1;
        velocity.x = targetDirection * runSpeed;
      }

    if(player2InRange())
    {
      targetDirection =
      (player2.x + player2Offset < position.x + chickenOffset) ? -1 : 1;
      velocity.x = targetDirection * runSpeed;
    }

    moveDirection = lerpDouble(moveDirection, targetDirection, 0.1) ?? 1;
    
    position.x += velocity.x * dt;
  }

  bool player1InRange()
  {
    double player1Offset = (player1.scale.x > 0) ? 0 : -player1.width;

    return player1.x + player1Offset >= rangeNeg &&
    player1.x + player1Offset <= rangePos &&
    player1.y + player1.height > position.y &&
    player1.y < position.y + height;
  }

  bool player2InRange()
  {
    double player2Offset = (player2.scale.x > 0) ? 0 : - player2.width;

    return player2.x + player2Offset >= rangeNeg &&
        player2.x + player2Offset <= rangePos &&
        player2.y + player2.height > position.y &&
        player2.y < position.y + height;
  }

  void _updateState()
  {
    current = (velocity.x != 0) ? State.run : State.idle;

    if((moveDirection > 0 && scale.x > 0) ||
        (moveDirection < 0 && scale.x < 0))
      {
        flipHorizontallyAroundCenter();
      }
  }

  void collidedWithPlayer1() async
  {
    if(player1.velocity.y > 0 && player1.y + player1.height > position.y)
      {
        if(game.playSounds)
          {
            FlameAudio.play('bounce.wav', volume : game.soundVolume);
          }
        gotStomped = true;
        current = State.hit;
        player1.velocity.y = -_bounceHeight;
        await animationTicker?.completed;
        removeFromParent();
      }
    else
      {
        player1.collidedWithEnemy();

      }
  }

  void collidedWithPlayer2() async
  {
    if(player2.velocity.y > 0 && player2.y + player2.height > position.y)
    {
      if(game.playSounds)
      {
        FlameAudio.play('bounce.wav', volume : game.soundVolume);
      }
      gotStomped = true;
      current = State.hit;
      player2.velocity.y = -_bounceHeight;
      await animationTicker?.completed;
      removeFromParent();
    }
    else
    {
      player2.collidedWithEnemy();
    }
  }

}