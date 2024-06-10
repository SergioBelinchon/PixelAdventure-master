import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OptionsScreen extends StatefulWidget {
  final bool initialShowControls;
  final bool initialPlaySounds;
  final Function(bool) onShowControlsChanged;
  final Function(bool) onPlaySoundsChanged;

  OptionsScreen({
    required this.initialShowControls,
    required this.initialPlaySounds,
    required this.onShowControlsChanged,
    required this.onPlaySoundsChanged,
  });

  @override
  _OptionsScreenState createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
  late bool _showControls;
  late bool _playSounds;

  @override
  void initState() {
    super.initState();
    _showControls = widget.initialShowControls;
    _playSounds = widget.initialPlaySounds;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Opciones',
          style: GoogleFonts.getFont(
            'Kdam Thmor Pro',
            textStyle: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CheckboxListTile(
              title: Text(
                'Mostrar HUD del Joypad',
                style: GoogleFonts.getFont(
                  'Kdam Thmor Pro',
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
              value: _showControls,
              onChanged: (value) {
                setState(() {
                  _showControls = value!;
                });
                widget.onShowControlsChanged(_showControls);
              },
            ),
            CheckboxListTile(
              title: Text(
                'Jugar con sonido',
                style: GoogleFonts.getFont(
                  'Kdam Thmor Pro',
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
              value: _playSounds,
              onChanged: (value) {
                setState(() {
                  _playSounds = value!;
                });
                widget.onPlaySoundsChanged(_playSounds);
              },
            ),
          ],
        ),
      ),
    );
  }
}
