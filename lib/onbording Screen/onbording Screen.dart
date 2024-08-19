import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class onbordingScreen extends StatefulWidget {
  static const String routeName = "onbordingScreen"; // Fixed typo in route name
  const onbordingScreen({super.key});

  @override
  State<onbordingScreen> createState() => _onbordingScreenState();
}

class _onbordingScreenState extends State<onbordingScreen> {
  @override
  Widget build(BuildContext context) {
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
            // Gradient overlay with CustomPaint
            Positioned.fill(
              child: CustomPaint(
                painter: GradientPainter(),
              ),
            ),
            // Positioned container with opacity

              Positioned(
                top: 779.16,  // Position from the top
                left: 25.5,    // Position from the left
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, "LoginScreen");
                      },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xff58AD53), // Example color
                          borderRadius: BorderRadius.circular(10)
                      ),
                      width: 353.0,  // Set width
                      height: 67.0,  // Set height
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
             ),
             Positioned(
               top:650 ,
               left: 100,
               child: Center(

                    child: Column(

                      children: [

                        Text("Welcome ",style: TextStyle(color: Colors.white,fontSize: 50,fontWeight: FontWeight.bold),),
                        Text("to our store ",style: TextStyle(color: Colors.white,fontSize: 50,fontWeight: FontWeight.bold,),),


                    ],
                    ),




                           ),
             )
          ],
        ),
      ),
    );
  }}

class GradientPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final Gradient gradient = LinearGradient(
      colors: [Colors.black.withOpacity(0.6), Colors.black.withOpacity(0.1)],
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
    );
    final Paint paint = Paint()
      ..shader = gradient.createShader(rect);

    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}