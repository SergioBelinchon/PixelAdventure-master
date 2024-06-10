import 'package:firebase_core/firebase_core.dart';
<<<<<<< HEAD
=======
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
/*
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

  @override
  Widget build(BuildContext context) {
    return _showGame
        ? GameWidget(game: _game)
        : MenuScreen(onPlay: _startGame);
  }
}

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GameWidget(game: PixelAdventure());
  }
}
*/
import 'package:firebase_core/firebase_core.dart';
>>>>>>> origin/master
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:pixeladventure/src/components/loading_screen.dart';
import 'package:pixeladventure/src/components/login_screen.dart';
import 'package:pixeladventure/src/components/main_screen.dart';
import 'package:pixeladventure/src/components/menu_screen.dart';
import 'package:pixeladventure/src/components/onboarding_screen.dart';
import 'package:pixeladventure/src/components/register_screen.dart';
import 'package:pixeladventure/src/components/splash_screen.dart';
import 'package:pixeladventure/src/pixel_adventure.dart';
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
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/onboarding': (context) => OnBoardingScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/main': (context) => MainScreen(),
        '/game': (context) => GameScreen(),
      },
    );
  }
}
