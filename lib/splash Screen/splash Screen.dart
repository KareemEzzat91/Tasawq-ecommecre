import 'dart:async';
import 'package:flutter/material.dart'; // Make sure to import Get if you're using GetX

class SplashScreen extends StatefulWidget {
  static const String routeName = "splashScreen"; // Fixed typo in route name
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int color1 = 0xff294C25;
  int color2 = 0xff58AD53;

  void _changeSplash() {
    // Swap colors
    final temp = color1;
    color1 = color2;
    color2 = temp;
    setState(() {
    });
  }

  @override
  void initState() {
    super.initState();

    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer t) => _changeSplash());

    Future.delayed(Duration(seconds: 3)).then(
          (val) {
        Navigator.of(context).pushReplacementNamed("onbordingScreen"); // Adjust as needed
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(color1), // Use color1 for background color
      body: Center(
        child: Image.asset(
          "Images/7ad26bdfbd694871980df5499b2d7878-free-removebg-preview.png", // Ensure this path is correct
        ),
      ),
    );
  }
}
