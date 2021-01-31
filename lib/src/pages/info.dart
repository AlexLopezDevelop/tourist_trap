import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class Info extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          ListTile(
            enabled: false,
            title: Text("Version number",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500)),
            trailing: FutureBuilder(
              future: getVersionNumber(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) =>
                  Text(
                    snapshot.hasData ? snapshot.data : "Loading ...",
                    style: TextStyle(color: Colors.black38),
                  ),
            ),
          ),
          ListTile(
            enabled: false,
            title: Text("Build number",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500)),
            trailing: FutureBuilder(
              future: getBuildNumber(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) =>
                  Text(
                    snapshot.hasData ? snapshot.data : "Loading ...",
                    style: TextStyle(color: Colors.black38),
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String> getVersionNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;

    return version;
  }

  Future<String> getBuildNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.buildNumber;

    return version;
  }
}