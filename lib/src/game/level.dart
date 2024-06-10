import 'dart:async';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:pixeladventure/src/game/player2.dart';
import 'package:pixeladventure/src/pixel_adventure.dart';

import '../colisiones/colision_bloque.dart';
import 'sierra.dart';
import 'checkpoint.dart';
import 'chicken.dart';
import 'fondo_tile.dart';
import 'fruit.dart';
import 'player1.dart';

class Level extends World with HasGameRef<PixelAdventure>
{

  final String levelName;
  final Player1 player1;
  //final Player2 player2;
  Level({required this.levelName, required this.player1 /*required this.player2*/});
  late TiledComponent level;
  List<ColisionBloque> colisionBloques = [];

  @override
  FutureOr<void> onLoad() async
  {
    level = await TiledComponent.load('$levelName.tmx', Vector2.all(16));

    add(level);

    _scrollingFondo();
    _spawnObjetos();
    _addColisiones();

    return super.onLoad();
  }

  void _scrollingFondo()
  {
    final capaFondo = level.tileMap.getLayer('Fondo');

    if(capaFondo != null)
    {
      final colorFondo =
      capaFondo.properties.getValue('ColorFondo');
      final fondoTile = FondoTile(
        color : colorFondo ?? 'Gray',
        position: Vector2(0, 0),
      );
      add(fondoTile);
    }
  }

  void _spawnObjetos()
  {
    final capaZonaSpawn = level.tileMap.getLayer<ObjectGroup>('ZonaSpawn');

    if(capaZonaSpawn != null)
    {
      for(final zonaSpawn in capaZonaSpawn.objects)
      {
        switch(zonaSpawn.class_)
        {
          case 'Player1' :
            player1.position = Vector2(zonaSpawn.x, zonaSpawn.y);
            player1.scale.x = 1;
            add(player1);
            break;
          /*case 'Player2' :
            player2.position = Vector2(zonaSpawn.x, zonaSpawn.y);
            player2.scale.x = 1;
            add(player2);
            break;*/
          case 'Fruit' :
            final fruit = Fruit(
              fruit: zonaSpawn.name,
              position: Vector2(zonaSpawn.x, zonaSpawn.y),
              size: Vector2(zonaSpawn.width, zonaSpawn.height),
            );
            add(fruit);
            break;
          case 'Sierra' :
            final esVertical = zonaSpawn.properties.getValue('esVertical');
            final offNeg = zonaSpawn.properties.getValue('offNeg');
            final offPos = zonaSpawn.properties.getValue('offPos');
            final sierra = Sierra(
                esVertical: esVertical,
                offNeg: offNeg,
                offPos: offPos,
                position: Vector2(zonaSpawn.x, zonaSpawn.y),
                size: Vector2(zonaSpawn.width, zonaSpawn.height)
            );
            add(sierra);
            break;
          case 'Checkpoint' :
            final checkpoint = Checkpoint(
                position: Vector2(zonaSpawn.x, zonaSpawn.y),
                size: Vector2(zonaSpawn.width, zonaSpawn.height)
            );
            add(checkpoint);
            break;
          case 'Chicken':
            final offNeg = zonaSpawn.properties.getValue('offNeg');
            final offPos = zonaSpawn.properties.getValue('offPos');
            final chicken = Chicken(
              position: Vector2(zonaSpawn.x, zonaSpawn.y),
              size: Vector2(zonaSpawn.width, zonaSpawn.height),
              offNeg: offNeg,
              offPos: offPos,
            );
            add(chicken);
            break;
          default:
        }
      }
    }
  }

  void _addColisiones()
  {
    final capaColisiones = level.tileMap.getLayer<ObjectGroup>('Colisiones');

    if(capaColisiones != null)
    {
      for(final colision in capaColisiones.objects)
      {
        switch(colision.class_)
        {
          case 'Plataformas' :
            final plataforma = ColisionBloque(
              position: Vector2(colision.x, colision.y),
              size: Vector2(colision.width, colision.height),
              isPlataforma: true,
            );
            colisionBloques.add(plataforma);
            add(plataforma);
            break;
          default:
            final bloque = ColisionBloque(
              position: Vector2(colision.x, colision.y),
              size: Vector2(colision.width, colision.height),
            );
            colisionBloques.add(bloque);
            add(bloque);
        }
      }
    }
    player1.colisionBloques = colisionBloques;
    //player2.colisionBloques = colisionBloques;

  }
}
