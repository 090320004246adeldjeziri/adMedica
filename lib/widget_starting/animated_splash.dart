import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:medical/auth/login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );

    // Generate random colors excluding green for the animation
    _colorAnimation = ColorTween(
      begin: _generateRandomColorExcludingGreen(),
      end: _generateRandomColorExcludingGreen(),
    ).animate(_animationController);

    // Start the animation
    _animationController.forward();

    // Navigate to the next screen after the animation is complete
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    });
  }

  @override
  void dispose() {
    // Dispose the animation controller
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) {
        return Container(
          color: _colorAnimation.value,
          child: Center(
            child: Image.asset(
              'assets/images/dawa.png',
              fit: BoxFit.contain,
              width: 180,
              height: 180,
            ),
          ),
        );
      },
    );
  }

  Color _generateRandomColorExcludingGreen() {
    // Generate a random color excluding green
    Color color;
    do {
      color = Color.fromRGBO(
        Random().nextInt(256),
        Random().nextInt(256), 
        Random().nextInt(256), 
        255, // Alpha (opacity)
      );
    } while (color == Colors.green);
    return color;
  }
}
