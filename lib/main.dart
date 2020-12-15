import 'package:flutter/material.dart';
import 'package:tourist_trap/src/pages/navigator.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Future<void> initState() async {
    print("espana");
    var status = await Permission.location.status;
    if (status.isUndetermined) {
      print("paco");
      // We didn't ask for permission yet.
    }
    if (await Permission.contacts.request().isGranted) {
      print("okey");
      // Either the permission was already granted before or the user just granted it.
    }
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tourist Trap',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: NavigatorController(),
      ),
    );
  }
}
