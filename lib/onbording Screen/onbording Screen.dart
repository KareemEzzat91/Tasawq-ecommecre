import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../Login Screen/login.dart';

class onbordingScreen extends StatefulWidget {
  static const String routeName = "onboardingScreen"; // Fixed typo in route name
  const onbordingScreen({super.key});

  @override
  State<onbordingScreen> createState() => _onbordingScreenState();
}

class _onbordingScreenState extends State<onbordingScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    print("=================$height");
    print("=================$width");
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: Image.asset(
                "Images/onbording.png",
                fit: BoxFit.cover,
              ),
            ),

              Positioned(
                top: height*0.88,  // Position from the top
                left: 25.5,    // Position from the left
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GestureDetector(
                      onTap: (){
                          Navigator.pushNamed(context, "LoginScreen");

                      },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xff58AD53), // Example color
                          borderRadius: BorderRadius.circular(10)
                      ),
                      width: width*0.8,  // Set width
                      height: height*0.08,  // Set height
                      child: Center(
                        child: Text(
                          'Get Started !',
                          style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
             Padding(
               padding: const EdgeInsets.only(top: 120),
               child: Center(
                 child: Image.asset("Images/7ad26bdfbd694871980df5499b2d7878-free-removebg-preview.png"),
               ),
             ),//Tasawq logo
             Positioned(
               top:height*0.7 ,
               left: width*0.19,
               child: Center(

                    child: Column(

                      children: [

                        Text("Welcome ",style: TextStyle(color: Colors.white,fontSize: 50,fontWeight: FontWeight.bold),),
                        Text("to our store ",style: TextStyle(color: Colors.white,fontSize: 50,fontWeight: FontWeight.bold,),),


                    ],
                    ),




                           ),
             )//welcome to our store
          ],
        ),
      ),
    );
  }}


