import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yellow_class_tube/screens/homeScreen/home_screen.dart';
import 'package:yellow_class_tube/screens/landingScreen/landing_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'Yellow Class Tube',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        bottomNavigationBarTheme:
            BottomNavigationBarThemeData(selectedItemColor: Colors.white),
        primarySwatch: Colors.blue,
      ),
      home: LandingScreen(),
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        LandingScreen.id: (context) => LandingScreen(),
      },
    );
  }
}
