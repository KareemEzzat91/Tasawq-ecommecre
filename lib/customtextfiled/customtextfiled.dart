import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../responsive/responsive.dart';

class CustomTextField extends StatefulWidget {
  final String text;
  final double height;
  final bool isPassword;
  final String? Function(String?)? validator;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.text,
    required this.height,
    this.isPassword = false,
    this.validator,
    required this.controller,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          style: TextStyle(color: Colors.black,fontSize: Responsive.isMobile(context)? 15 :50 ),
        ),
        SizedBox(
          height: widget.height * .01,
        ),
        TextFormField(
          obscureText: _obscureText && widget.isPassword,

          validator: widget.validator,
          controller: widget.controller,
          style: TextStyle(fontSize:Responsive.isMobile(context)?20 :50),
          decoration: InputDecoration(

            focusedBorder: OutlineInputBorder(

              borderSide: BorderSide(color: Color(0xff58AD53)),
              borderRadius: BorderRadius.circular(20),

            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff58AD53)),
              borderRadius: BorderRadius.circular(20),
            ),
            fillColor: Colors.green[50], // Change this if you want a different shade or keep it as is
            filled: true, // Make sure to set this to true to apply fillColor
            suffixIcon: widget.isPassword
                ? IconButton(
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              icon: Icon(
                _obscureText
                    ? CupertinoIcons.eye
                    : CupertinoIcons.eye_slash,
              ),
            )
                : null,
          ),
        ),
      ],
    );
  }
}