// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCDqJtbQBU3qjELXl1Eb_jW8jgkh2JgSBo',
    appId: '1:303892929690:web:5bc77be61eaa01aa40d323',
    messagingSenderId: '303892929690',
    projectId: 'ecommerce-568a3',
    authDomain: 'ecommerce-568a3.firebaseapp.com',
    storageBucket: 'ecommerce-568a3.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDG1cHdxhk1qCT6fs8rR0EGvxrxg8axWpk',
    appId: '1:303892929690:android:71b06f34444d1ff440d323',
    messagingSenderId: '303892929690',
    projectId: 'ecommerce-568a3',
    storageBucket: 'ecommerce-568a3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBogNZS-bc5LoPPWtz9zVozY7qJ11E59_g',
    appId: '1:303892929690:ios:17f53bf8997448ed40d323',
    messagingSenderId: '303892929690',
    projectId: 'ecommerce-568a3',
    storageBucket: 'ecommerce-568a3.appspot.com',
    iosBundleId: 'com.example.ecommerce',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBogNZS-bc5LoPPWtz9zVozY7qJ11E59_g',
    appId: '1:303892929690:ios:17f53bf8997448ed40d323',
    messagingSenderId: '303892929690',
    projectId: 'ecommerce-568a3',
    storageBucket: 'ecommerce-568a3.appspot.com',
    iosBundleId: 'com.example.ecommerce',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCDqJtbQBU3qjELXl1Eb_jW8jgkh2JgSBo',
    appId: '1:303892929690:web:78afb6618841404a40d323',
    messagingSenderId: '303892929690',
    projectId: 'ecommerce-568a3',
    authDomain: 'ecommerce-568a3.firebaseapp.com',
    storageBucket: 'ecommerce-568a3.appspot.com',
  );
}