import 'package:flame/components.dart';
import 'package:pixeladventure/src/pixel_adventure.dart';



class Hud extends PositionComponent with HasGameReference<PixelAdventure> {
  Hud({
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.children,
    super.priority = 5,
  });


}