import 'package:flutter/material.dart';
import 'package:green_minds/screens/home.dart';
import 'package:green_minds/screens/perdict_screen.dart';
import 'package:green_minds/screens/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Green Minds',
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (context) => SplashScreen(),
          Home.routeName: (context) => Home(),
          CropInputScreen.routeName: (context) => CropInputScreen(),
        });
  }
}
