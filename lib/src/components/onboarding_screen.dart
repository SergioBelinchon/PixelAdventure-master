import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'background_widget.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool _showInfo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Pixel Adventure",
                style: GoogleFonts.getFont(
                  'Kdam Thmor Pro',
                  textStyle: TextStyle(
                    fontSize: 50,
                    color: Colors.grey,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: Text(
                  "Iniciar",
                  style: GoogleFonts.getFont(
                    'Kdam Thmor Pro',
                    textStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _showInfo = true;
                  });
                },
                child: Text(
                  "Información del Juego",
                  style: GoogleFonts.getFont(
                    'Kdam Thmor Pro',
                    textStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              if (_showInfo)
                Text(
                  "Este juego ha sido desarrollado con Flutter y Dart. Los controles básicos son moverse con las flechas del teclado y saltar con la barra espaciadora.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.getFont(
                    'Kdam Thmor Pro',
                    textStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
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
