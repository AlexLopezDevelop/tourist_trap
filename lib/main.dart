import 'package:flutter/material.dart';
import 'package:tourist_trap/src/pages/navigator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tourist Trap',
      home: Scaffold(
        body: NavigatorController(),
      ),
    );
  }
}
