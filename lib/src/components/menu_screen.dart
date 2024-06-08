import 'package:flutter/material.dart';
import 'background_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuScreen extends StatelessWidget {
  final VoidCallback onPlay;

  MenuScreen({required this.onPlay});

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
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: BackgroundWidget( // Aquí envuelve el contenido con tu widget de fondo
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
                    color: Colors.white,
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
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Opciones no implementadas')),
                  );
                },
                child: Text(
                  'Opciones',
                  style: GoogleFonts.getFont(
                    'Kdam Thmor Pro',
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
