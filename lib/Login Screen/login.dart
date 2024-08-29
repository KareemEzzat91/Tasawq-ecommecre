import 'package:ecommerce/customtextfiled/customtextfiled.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../MainScreens/MainScreen.dart';
import 'Logincubit/login_cubit.dart';

class Login extends StatefulWidget {
  static const String routeName = "LoginScreen"; // Fixed typo in route name

  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  late final String? Function(String?)? validator;
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;
    return BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
      if (state is Loginerrorstate) {
        Get.snackbar(
          "Error",
         state.msg,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Form(
            key:_key ,
            child: Stack(
                children: [
                  Transform.scale(
      
                    scale: 1.4,
                    child: Transform.translate(
                      offset: Offset(0, -height / 4.86),
                      child: Container(
                        width: width,
                        height: height / 2,
                        decoration: BoxDecoration(
                          color: Color(0xff58AD53),
                          borderRadius: BorderRadius.circular(width),
      
                        ),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      height: height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // Center contents vertically
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // Center contents horizontally
                        children: [
                          Center(
                            child: Image.asset(
                              "Images/7ad26bdfbd694871980df5499b2d7878-free-removebg-preview.png",
                              fit: BoxFit.cover, // Fit image to container
                              width: 200, // Set width as needed
                              height: 200, // Set height as needed
                            ),
                          ),
                          SizedBox(height: 20),
                          // Add spacing between image and text field
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomTextField(
                              controller: _nameController,
                              height: height,
                              text: "Email",
                              validator: (val) {
                                if (!val!.isEmail) {
                                  return "this should be valid Email.";
                                } else if (val.length < 10) {
                                  return " email should be more than 10 letters";
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: height * .02,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomTextField(
                              height: height,
                              controller: _passwordController,
                              text: "Password",
                              isPassword: true,
                              validator: (val) {
                                if (val!.length < 6) {
                                  return "Password should be more than 7 letters";
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: height * .02,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Container(
                              alignment: Alignment.center,
                              child: const Text("Did you forget your password?",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xff58AD53),
                                ),
                              ),
                            ),
                          ),
      
                      BlocBuilder<LoginCubit, LoginState>(
                        builder: (context, state) { return buildGestureDetector("Login",state);},),
                      BlocBuilder<LoginCubit, LoginState>(
                        builder: (context, state) { return buildGestureDetector("Sign Up",state);},)
                        ],
                      ),
                    ),
                  ),
                ]
            ),
          ),
        ),
    );
    
  }
  Widget _loginWidget(LoginState state, String name) {
    if (state is LoginLoadingstate) {
      return Center(
        child:  CircularProgressIndicator(),
      );
    }
    return  Center(
      child: Text(
        name,
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    );
  }

  InkWell buildGestureDetector(String Tx,LoginState state) {
    final bloc = context.read<LoginCubit>();
    return InkWell(
      onTap: () {
        if (Tx == 'Login'){
        bloc.login( context, _key,_nameController,_passwordController);}
        else {
          bloc.Registerlog(context) ;
        }


      },
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xff58AD53),
              boxShadow: const [
                BoxShadow(color: Colors.black,
                    blurRadius: 10,
                    blurStyle: BlurStyle.outer)
              ]
          ),
          child: _loginWidget(state,Tx),

        ),
      ),
    );
  }
}
