import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttergram/responsive_layout/mobile_screen_layout.dart';
import 'package:fluttergram/responsive_layout/responsive_layout.dart';
import 'package:fluttergram/responsive_layout/web_screen_layout.dart';
import 'package:fluttergram/screens/login_screen.dart';
import 'package:fluttergram/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await const FirebaseOptions(
        apiKey: "AIzaSyBoUQh7kWqNpeZsPAzixCqhFxGjQs9gh2k",
        appId: "1:864171316689:web:432b44b6a2c792b2963cf0",
        messagingSenderId: "864171316689",
        projectId: "flutter-gram-6511b",
        storageBucket: "flutter-gram-6511b.appspot.com");
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      home: const ResponsiveLayout(
        mobileScreenLayout: MobileScreenLayout(),
        webScreenLayout: WebScreenLayout(),
      ),
    );
  }
}
