import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'background_widget.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _login() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Navigator.of(context).pushReplacementNamed('/main');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error en el login: $e'),
      ));
    }
  }

  void _navigateToRegister() {
    Navigator.of(context).pushNamed('/register');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: GoogleFonts.getFont('Kdam Thmor Pro'),
                ),
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                    labelText: 'Contraseña',
                    labelStyle: GoogleFonts.getFont('Kdam Thmor Pro'),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                child: Text('Login',
                  style: GoogleFonts.getFont('Kdam Thmor Pro')),
                ),
              ElevatedButton(
                onPressed: _navigateToRegister,
                child: Text('Registrarse',
                    style: GoogleFonts.getFont('Kdam Thmor Pro')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
