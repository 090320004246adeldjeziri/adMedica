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
      duration: Duration(seconds: 2),
    );

    // Start the animation
    _animationController.forward();

    // Create a list of colors excluding green
    List<Color> colors = _generateColorsExcludingGreen();

    _colorAnimation = ColorTweenSequence(
      // Generate ColorTweenSequence using the list of colors
      List.generate(
        colors.length - 1,
        (index) => ColorTween(
          begin: colors[index],
          end: colors[index + 1],
        ),
      ),
    ).animate(_animationController);

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

  List<Color> _generateColorsExcludingGreen() {
    // Generate a list of all possible colors excluding green
    List<Color> colors = [];
    for (int r = 0; r <= 255; r++) {
      for (int g = 0; g <= 255; g++) {
        for (int b = 0; b <= 255; b++) {
          if (g != 255) { // Exclude green
            colors.add(Color.fromRGBO(r, g, b, 1));
          }
        }
      }
    }
    return colors;
  }
}
