import 'package:flame/components.dart';

class ColisionBloque extends PositionComponent
{
  bool isPlataforma;
  ColisionBloque({
    position, size,
    this.isPlataforma = false,
  }) : super (
      position: position,
    size: size,
  ) {
    //debugMode = true;
  }
}