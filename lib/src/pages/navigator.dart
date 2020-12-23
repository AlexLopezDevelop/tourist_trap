import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tourist_trap/src/pages/list_overview.dart';
import 'package:tourist_trap/src/pages/map_overview.dart';

class NavigatorController extends StatefulWidget {
  NavigatorController({Key key}) : super(key: key);

  _NavigatorController createState() => new _NavigatorController();
}

class _NavigatorController extends State<NavigatorController> {
  int currentPage = 0;
  List<Widget> tabs = <Widget>[
    //CameraScreen(widget.cameras),
    MapOverview(),
    ListOverview(),
    Container(
      color: Colors.red,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentPage],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          setState(() {
            this.currentPage = index;
          });
          //_navigateToScreens(index);
        },
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: "Puntos",
            icon: Container(
              width: 25,
              height: 25,
              child: SvgPicture.asset(
                currentPage == 0
                    ? "assets/icons/map-icon-selected.svg"
                    : "assets/icons/map-icon.svg",
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: "Más información",
            icon: Container(
              width: 25,
              height: 25,
              child: SvgPicture.asset(
                currentPage == 1
                    ? "assets/icons/info-icon-selected.svg"
                    : "assets/icons/info-icon.svg",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
