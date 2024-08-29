import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ecommerce/Api_List/ApiHelper.dart';
import 'package:ecommerce/Api_List/KAPI.dart';
import 'package:ecommerce/Login%20Screen/Register.dart';
import 'package:ecommerce/splash%20Screen/Hivehelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:meta/meta.dart';

import '../../MainScreens/MainScreen.dart';
import '../LoginModel/LoginModel.dart';
import '../RegisterModel/RegisterModel.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {

  LoginCubit() : super(LoginInitial());
  LoginModel loginModel = LoginModel();
  RegisterModel registerModel = RegisterModel();


  void login( BuildContext context, var _key,TextEditingController email, TextEditingController password) async {
    try {
      emit(LoginLoadingstate());
        if( _key.currentState!.validate()) {
          final response = await Apihelper.postData(
            path:Kapi.login,
            body: {
              "email": email.text,
              "password": password.text,
            },
          );
          loginModel = LoginModel.fromJson(response.data);
          if (loginModel.status ?? false) {
            Hivehelper.init();
            Navigator.pushNamed(context, "Mainscreen");
            emit(LoginSuccesstate());
          }
          else {emit(Loginerrorstate(loginModel.message.toString()));}
        }
        else emit(Loginerrorstate(loginModel.message.toString()));
        } catch (e) {
      emit(Loginerrorstate(e.toString()));
    }
  }
  void Register( BuildContext context,TextEditingController email,TextEditingController name,TextEditingController password, TextEditingController phone) async {
    try {
      emit(LoginLoadingstate());
      final response = await Apihelper.postData(path: Kapi.register,body: {
        "email":email.text,
        "name":name.text,
        'password':password.text,
        'phone':phone.text,
        'image': "https://th.bing.com/th/id/OIP.UYagQDMo7CCbBLXOPB5etAHaHa?rs=1&pid=ImgDetMain"


      });
      registerModel=  RegisterModel.fromJson(response.data);
      print("Start++++++++++");

      if(registerModel.status??false)
        {
          print("Successssss++++++++++");

        Navigator.pushNamedAndRemoveUntil(context, "Mainscreen",(Route<dynamic> route) => false);
          emit(LoginSuccesstate());
        }
      else{
        emit(Loginerrorstate(registerModel.message.toString()));
      }
        } catch (e) {
      print(e.toString());

      emit(Loginerrorstate(e.toString()));
    }
  }
  void Registerlog(BuildContext context)  {
    Navigator.pushNamed(context, RegisterScreen.routenmae);
  }


}


