import 'dart:async';
import 'package:ecommerce/Api_List/ApiHelper.dart';
import 'package:ecommerce/onbording%20Screen/onbording%20Screen.dart';
import 'package:ecommerce/splash%20Screen/Hivehelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../MainScreens/MainScreen.dart'; // Make sure to import Get if you're using GetX

class SplashScreen extends StatefulWidget {
  static const String routeName = "splashScreen"; // Fixed typo in route name
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  int color1 = 0xff294C25;
  int color2 = 0xff58AD53;

  void _changeSplash() {
    final temp = color1;
    color1 = color2;
    color2 = temp;
    print ("hello +==========");
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3)).then(
          (val) {
                  Get.offAll(onbordingScreen());
            if(Hivehelper.checkfirst()){
              Navigator.of(context).pushNamed("onboardingScreen"); // Adjust as needed
            }
            else {
              Get.offAll(Mainscreen());
            }
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the Timer when the widget is disposed
    super.dispose();
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
