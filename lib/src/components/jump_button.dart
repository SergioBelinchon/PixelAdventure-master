import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:pixeladventure/src/pixel_adventure.dart';

class JumpButton extends SpriteComponent with HasGameRef<PixelAdventure>, TapCallbacks {
  JumpButton();

  final margin = 32;
  final double buttonSize = 64;

  @override
  FutureOr<void> onLoad() {
    sprite = Sprite(game.images.fromCache('HUD/JumpButton.png'));
    size = Vector2(buttonSize, buttonSize);
    position = Vector2(
      game.size.x - margin - buttonSize,
      game.size.y - margin - buttonSize,
    );
    priority = 100; // Asegurar una alta prioridad de renderizado
    return super.onLoad();
  }

  @override
  void onGameResize(Vector2 canvasSize) {
    super.onGameResize(canvasSize);
    position = Vector2(
      canvasSize.x - margin - buttonSize,
      canvasSize.y - margin - buttonSize,
    );
  }

  @override
  void onTapDown(TapDownEvent event) {
    game.player1.haSaltado = true;
    //game.player2.haSaltado = true;
    super.onTapDown(event);
  }

  @override
  void onTapUp(TapUpEvent event) {
    game.player1.haSaltado = false;
    //game.player2.haSaltado = false;
    super.onTapUp(event);
  }
}
