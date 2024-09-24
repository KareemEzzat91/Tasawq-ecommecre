import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';


import '../customtextfiled/customtextfiled.dart';
import '../responsive/responsive.dart';
import 'Logincubit/login_cubit.dart';

class RegisterScreen extends StatefulWidget {
  static final String routenmae ="RegisterScreen";
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final String? Function(String?)? validator;
  final _nameController = TextEditingController();
  final _EmailController = TextEditingController();
  final _phoneController = TextEditingController();
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

      listener: (BuildContext context, LoginState state) {
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
        body:SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key:_key ,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("Images/7ad26bdfbd694871980df5499b2d7878-free-removebg-preview.png"),
                
                  CustomTextField(
                    controller: _EmailController,
                    height: height,
                    text: "Email",
                    validator: (val) {
                      if (!val!.isEmail) {
                        return "this should be valid Email.";
                      } else if (val!.length < 10) {
                        return " email should be more than 10 letters";
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    controller: _nameController,
                    height: height,
                    text: "name",
                    validator: (val) {
                      if (val!.length < 4) {
                        return " name should be more than 4 letters";
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    controller: _passwordController,
                    height: height,
                    text: "Password",
                    isPassword: true,
                    validator: (val) {
                      if (val!.length < 7) {
                        return " Password should be more than 7 letters";
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    controller: _phoneController,
                    isPassword: true,
                    height: height,
                    text: "Phone",
                    validator: (val) {
                      int value = int.parse(val!);
                      if (value <10) {
                        return " it should be more than 12 ";}
                      else if (value =="")return"should be num only";
                      return null;
                
                    },
                  ),
                  SizedBox(height: height*0.04,),
                  BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                    if (state is LoginLoadingstate){return CircularProgressIndicator();}
                     else {
                      return buildGestureDetector("Sign Up");
                    }
                      },)
                
                ],),
            ),
          ),
        ) ,
      ),
    );
  }
  InkWell buildGestureDetector(String Tx) {
    final bloc = context.read<LoginCubit>();
    return InkWell(
      onTap: () {
      if(  _key.currentState!.validate())
        {
          bloc.Register(context, _EmailController, _nameController, _passwordController, _phoneController );
        }

      },
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Container(
          width: double.infinity,
          height: Responsive.isMobile(context)?60:100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xff58AD53),
              boxShadow: const [
                BoxShadow(color: Colors.black,
                    blurRadius: 10,
                    blurStyle: BlurStyle.outer)
              ]
          ),
          child: Center(child: Text(Tx, style: TextStyle(fontSize:  Responsive.isMobile(context)? 35 :50,
              fontWeight: FontWeight.bold,
              color: Colors.white),),),

        ),
      ),
    );
  }

}
