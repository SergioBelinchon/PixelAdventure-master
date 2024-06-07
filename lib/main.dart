/*
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

*/
/*
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:pixeladventure/src/components/menu_screen.dart';
import 'package:pixeladventure/src/pixel_adventure.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Flame.device.fullScreen();
  await Flame.device.setLandscape();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _showGame = false;
  late PixelAdventure _game;

  @override
  void initState() {
    super.initState();
    _game = PixelAdventure();  // Initialize the game instance
  }

  void _startGame() {
    setState(() {
      _showGame = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _showGame
        ? GameWidget(game: _game)
        : MenuScreen(onPlay: _startGame);
  }
}*/
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:pixeladventure/src/components/menu_screen.dart';
import 'package:pixeladventure/src/pixel_adventure.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => MainScreen(),
        '/game': (context) => GameScreen(),
        '/levelSelection': (context) => LevelSelectionScreen(onLevelSelected: () {}),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _showGame = false;
  bool _showLevelSelection = false;
  late PixelAdventure _game;

  @override
  void initState() {
    super.initState();
    _game = PixelAdventure(); // Inicializa la instancia del juego
  }

  void _startGame() {
    setState(() {
      _showGame = true;
    });
  }

  void _showLevelSelectionScreen() {
    setState(() {
      _showLevelSelection = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _showGame
        ? GameWidget(game: _game)
        : _showLevelSelection
        ? LevelSelectionScreen(onLevelSelected: _startGame)
        : MenuScreen(onPlay: _showLevelSelectionScreen);
  }
}

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GameWidget(game: PixelAdventure());
  }
}

class LevelSelectionScreen extends StatelessWidget {
  final Function() onLevelSelected;

  LevelSelectionScreen({required this.onLevelSelected}); // Se añade el argumento requerido en el constructor

  @override
  Widget build(BuildContext context) {
    // Aquí implementa la pantalla de selección de niveles
    return Container(
      color: Colors.blue,
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            // Cuando el usuario selecciona un nivel, llama a la función onLevelSelected
            onLevelSelected();
          },
          child: Text('Seleccionar nivel'),
        ),
      ),
    );
  }
}
