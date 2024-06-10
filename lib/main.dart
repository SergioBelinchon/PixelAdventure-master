import 'package:firebase_core/firebase_core.dart';
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

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GameWidget(game: PixelAdventure());
  }
}
