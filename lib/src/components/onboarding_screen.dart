import 'package:flutter/material.dart';
import 'background_widget.dart'; // Asegúrate de importar tu widget de fondo
import 'package:google_fonts/google_fonts.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool _showInfo = false; // Variable para controlar la visibilidad del mensaje

  void _toggleInfo() {
    setState(() {
      _showInfo = !_showInfo;
    });
  }

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
                style: GoogleFonts.getFont('Kdam Thmor Pro',
                    textStyle: TextStyle(fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: Text(
                  "Iniciar",
                  style: GoogleFonts.getFont('Kdam Thmor Pro',
                      textStyle: TextStyle(fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _toggleInfo,
                child: Text(
                  "Información sobre el juego",
                  style: GoogleFonts.getFont('Kdam Thmor Pro',
                      textStyle: TextStyle(fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
              ),
              if (_showInfo) // Mostrar el mensaje si _showInfo es true
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Este videojuego ha sido desarrolado con flutter y dart. Espero que les guste ;)",
                    style: GoogleFonts.getFont('Kdam Thmor Pro',
                        textStyle: TextStyle(fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.white)),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
