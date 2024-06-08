import 'package:flutter/material.dart';
import 'background_widget.dart'; // Asegúrate de importar tu widget de fondo
import 'package:google_fonts/google_fonts.dart';

class OnBoardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Bienvenidx a Pixel Adventure",
                style: GoogleFonts.getFont('Kdam Thmor Pro',
                    textStyle: TextStyle(fontSize: 50,
                        color: Colors.white)),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: Text(
                  "Iniciar",
                  style: GoogleFonts.getFont('Kdam Thmor Pro',
                      textStyle: TextStyle(fontSize: 20,
                          color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
