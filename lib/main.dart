import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pixeladventure/src/pixel_adventure.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

   await Flame.device.fullScreen();
   await Flame.device.setLandscape();
/*
  Widget initialWidget = LoginView();
  // Aquí puedes implementar la lógica condicional para decidir qué widget mostrar
  // Por ejemplo, si existe un usuario logueado
  bool userLoggedIn = false; // Aquí debes añadir la lógica de si el usuario está logueado

  if (userLoggedIn) {
    initialWidget = PixelAdventure() as Widget;
  }

  runApp(MaterialApp(
    home: initialWidget,
  ));
*/

  PixelAdventure game = PixelAdventure();
  runApp(GameWidget(game: kDebugMode? PixelAdventure() : game),
  );
}


