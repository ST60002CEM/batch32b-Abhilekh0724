import 'package:flutter/material.dart';
import 'package:venuevendor/screen/dashboard_screen.dart';
import 'package:venuevendor/screen/splash_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:DashboardScreen (),
    );
  }
}
