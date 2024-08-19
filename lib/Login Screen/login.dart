import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  static const String routeName = "LoginScreen"; // Fixed typo in route name

  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
    Widget build(BuildContext context) {
      return MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center contents vertically
            crossAxisAlignment: CrossAxisAlignment.center, // Center contents horizontally
            children: [
              Center(
                child: Image.asset(
                  "Images/7ad26bdfbd694871980df5499b2d7878-free-removebg-preview.png",
                  fit: BoxFit.cover, // Fit image to container
                  width: 200, // Set width as needed
                  height: 200, // Set height as needed
                ),
              ),
              SizedBox(height: 20), // Add spacing between image and text field
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0), // Add padding around text field
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Username',
                  ),
                ),
              ),
              SizedBox(height: 30), // Add spacing between image and text field
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0), // Add padding around text field
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Password',
                  ),
                ),
              ),

            ],
          ),
        ),
      );
    }
}
