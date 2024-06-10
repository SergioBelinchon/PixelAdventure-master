import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:pixeladventure/src/components/loading_screen.dart';
import 'package:pixeladventure/src/components/menu_screen.dart';
import 'package:pixeladventure/src/components/options_screen.dart';
import 'package:pixeladventure/src/pixel_adventure.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _isLoading = false;
  bool _showGame = false;
  late PixelAdventure _game;

  @override
  void initState() {
    super.initState();
    _game = PixelAdventure();
  }

  Future<void> _startGame() async {
    setState(() {
      _isLoading = true;
    });

    // Espera a que el juego se cargue completamente
    await _game.onLoad();

    setState(() {
      _isLoading = false;
      _showGame = true;
    });
  }

  void _showOptions() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => OptionsScreen(
          initialShowControls: _game.showControls,
          initialPlaySounds: _game.playSounds,
          onShowControlsChanged: (value) {
            setState(() {
              _game.showControls = value;
            });
          },
          onPlaySoundsChanged: (value) {
            setState(() {
              _game.playSounds = value;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return LoadingScreen();
    }
    return _showGame
        ? GameWidget(game: _game)
        : MenuScreen(onPlay: _startGame, onOptions: _showOptions);
  }
}
