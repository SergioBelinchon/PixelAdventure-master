import 'package:flame/components.dart';
import 'package:pixeladventure/src/pixel_adventure.dart';

enum HeartState {
  available,
  unavailable,
}


class ContadorVidas extends SpriteAnimationGroupComponent<HeartState>
    with HasGameReference<PixelAdventure>
{
  final int heartNumber;
   String corazon;

  ContadorVidas({
    this.corazon = 'heart',
    required this.heartNumber,
    required super.position,
    required super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.priority,
  });

  final double stepTime = 0.05;


  late final SpriteAnimation availableAnimation;
  late final SpriteAnimation unavailableAnimation;


  void _loadAllAnimations()
  {
    availableAnimation = _spriteAnimation("heart", 1);
    unavailableAnimation = _spriteAnimation("heart_half", 1);
  
    animations = {
    
    HeartState.available: availableAnimation,
      HeartState.unavailable: unavailableAnimation,
    };
    }


  @override
  Future<void> onLoad() async
  {
    _loadAllAnimations();
    await super.onLoad();

  }

  @override
  void update(double dt) {
    if (game.health < heartNumber) {
      current = HeartState.unavailable;
    } else {
      current = HeartState.available;
    }
    super.update(dt);
  }



  SpriteAnimation _spriteAnimation(String state, int amount)
  {
    return SpriteAnimation.fromFrameData(
      game.images.fromCache('Heart/$corazon.png'),
      SpriteAnimationData.sequenced(
        amount: 1,
        stepTime: stepTime,
        textureSize: Vector2.all(32),
      ),
    );
  }

}




