import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tourist_trap/src/tools/Tool.dart';
import '../models/Pois.dart';

class LocationListCard extends StatelessWidget {
  final Pois poi;

  LocationListCard({Key key, @required this.poi}) : super(key: key);

  Widget build(BuildContext context) {
    var distanceFromPoi = Geolocator.distanceBetween(37.77483, -122.41942,
        double.parse(poi.poi.latitud), double.parse(poi.poi.longitud));

    return GestureDetector(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10, top: 10.0),
          child: ListTile(
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: <Widget>[
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(60 / 2),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(poi.poi.image))),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          FittedBox(
                            fit: BoxFit.fill,
                            child: Text(
                              poi.poi.nombreEs,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5.0),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: 160.0,
                              ),
                              child: AutoSizeText(
                                poi.poi.direccion,
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 13),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 20,
                        height: 20,
                        child:
                            SvgPicture.asset("assets/icons/walking-icon.svg"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 5,
                          right: 15,
                        ),
                        child: Text(
                          Tool().distanceCalculator(distanceFromPoi),
                          style:
                              TextStyle(fontSize: 12, color: Color(0xff3c5cdc)),
                        ),
                      ),
                      Container(
                        width: 10,
                        height: 10,
                        child: SvgPicture.asset("assets/icons/next-icon.svg"),
                      ),
                    ],
                  )
                ]),
          ),
        ),
      ),
      onTap: () => Tool().showModalBottomMapDetail(poi, context),
    );
  }
}
