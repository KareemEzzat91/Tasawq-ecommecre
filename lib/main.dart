import 'package:device_preview/device_preview.dart';
import 'package:ecommerce/Login%20Screen/Register.dart';
import 'package:ecommerce/Login%20Screen/login.dart';
import 'package:ecommerce/MainScreens/MainScreen.dart';
import 'package:ecommerce/onbording%20Screen/onbording%20Screen.dart';
import 'package:ecommerce/splash%20Screen/Hivehelper.dart';
import 'package:ecommerce/splash%20Screen/splash%20Screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/adapters.dart';

import 'Api_List/ApiHelper.dart';
import 'Login Screen/Logincubit/login_cubit.dart';
import 'MainScreens/cubit/main_cubit.dart';
import 'firebase_options.dart';

void main() async{
  await Hive.initFlutter();
  Apihelper.init();

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var Box = await Hive.openBox(Hivehelper.Boxname);

  runApp( DevicePreview(builder:(context)=> const MyApp()));
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
  return MultiBlocProvider(
      providers: [

        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => MainCubit()),
      ],
      child: GetMaterialApp(
        builder: DevicePreview.appBuilder,

          home: SplashScreen() ,
          routes: {
            SplashScreen.routeName: (context) => SplashScreen(),
            onbordingScreen.routeName :(context)=>onbordingScreen(),
            Login.routeName :(context)=>Login(),
            Mainscreen.routename:(context)=>Mainscreen(),
            RegisterScreen.routenmae:(context)=>RegisterScreen(),

          }

      ),
    );

  }
}

