import 'package:flutter/material.dart';
import 'home_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  void initState() {
    super.initState();

    // Navigate automatically after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 900),
          pageBuilder: (context, animation, secondaryAnimation) =>
          const HomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {

            // Slide animation
            var begin = const Offset(1.0, 0.0);
            var end = Offset.zero;
            var curve = Curves.easeInOut;

            var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF715BE8),
      body: Stack(
        children: [

          /// RIGHT SIDE IMAGE
          Positioned(
            right: -230,
            bottom: 0,
            top: 0,
            child: Align(
              alignment: Alignment.centerRight,
              child: Image.asset(
                "assets/avatar1.png",
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ),
            ),
          ),

          /// VERTICAL WELCOME TEXT
          Positioned(
            left: -10,
            top: MediaQuery.of(context).size.height * 0.20,
            child: RotatedBox(
              quarterTurns: 3,
              child: const Text(
                "Welcome",
                style: TextStyle(
                  fontSize: 130,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
