import 'package:flutter/material.dart';
import 'src/screens/landing_page.dart';

void main() {
  runApp(VirtualProtestApp());
}

class VirtualProtestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Virtual Protests',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.orange, // Used for the accent color
        ),
        // Other theme properties
      ),
      home: LandingPage(),
    );
  }
}
