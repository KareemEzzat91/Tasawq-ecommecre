import 'package:ecommerce/Login%20Screen/login.dart';
import 'package:ecommerce/onbording%20Screen/onbording%20Screen.dart';
import 'package:ecommerce/splash%20Screen/splash%20Screen.dart';
import 'package:flutter/material.dart';

void main() {

  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        initialRoute: SplashScreen.routeName ,
        routes: {
          SplashScreen.routeName: (context) => SplashScreen(),
          onbordingScreen.routeName :(context)=>onbordingScreen(),
          Login.routeName :(context)=>Login(),

        }

    );

  }
}

