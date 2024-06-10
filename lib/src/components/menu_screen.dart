import 'package:flutter/material.dart';
import 'background_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuScreen extends StatelessWidget {
  final VoidCallback onPlay;
  final VoidCallback onOptions;

  MenuScreen({required this.onPlay, required this.onOptions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Menu',
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
      body: BackgroundWidget(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Pixel Adventure',
                style: GoogleFonts.getFont(
                  'Kdam Thmor Pro',
                  textStyle: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: onPlay,
                child: Text(
                  'Jugar',
                  style: GoogleFonts.getFont(
                    'Kdam Thmor Pro',
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: onOptions,
                child: Text(
                  'Opciones',
                  style: GoogleFonts.getFont(
                    'Kdam Thmor Pro',
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
