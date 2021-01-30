import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tourist_trap/src/tools/Tool.dart';
import '../models/Pois.dart';

class ModalMapDetail extends StatelessWidget {

  final Pois poi;

  ModalMapDetail({Key key, @required this.poi}) : super(key: key);

  Widget build(BuildContext context) {
    var distanceFromPoi = Geolocator.distanceBetween( 37.77483, -122.41942, double.parse(poi.poi.latitud), double.parse(poi.poi.longitud));

    return Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(child: Container(width: 150, height: 150, child: GoogleMap(
                  onMapCreated: (GoogleMapController controller) {},
                  initialCameraPosition: CameraPosition(
                    target: LatLng(double.parse(poi.poi.latitud), double.parse(poi.poi.longitud)),
                    zoom: 15,
                  ),
                  mapType: MapType.normal,
                  myLocationEnabled: true,
                  mapToolbarEnabled: false,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                ),)),
                Expanded(child: Container(width: 150, height: 150, decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(poi.poi.image),
                  ),
                ),)),
              ],
            ),
            Container(margin: EdgeInsets.all(10.0), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        poi.poi.nombreEs,
                        style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5.0),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: 220.0,
                          ),
                          child: AutoSizeText(
                            poi.poi.direccion,
                            style: TextStyle(color: Colors.grey, fontSize: 13),
                          ),
                        ),)

                    ],
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: 20,
                    height: 20,
                    child: SvgPicture.asset("assets/icons/walking-icon.svg"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 5,
                      right: 15,
                    ),
                    child: Text(
                      Tool().distanceCalculator(distanceFromPoi),
                      style: TextStyle(fontSize: 12, color: Color(0xff3c5cdc)),
                    ),
                  ),
                ],
              )
            ]),),
            Container(width: MediaQuery.of(context).size.width, height: 0.5, color: Colors.grey,),
            Container(
              margin: EdgeInsets.only(top: 30.0),
              child: Center(
                child: Container(
                    child: Column(
                      children: <Widget>[
                        Text("Quieres puntuar este espacio?"),
                        Container(margin: EdgeInsets.only(top: 20, bottom: 15), child: RatingBar.builder(
                          initialRating: 3,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),),
                        RaisedButton(
                          color: Colors.blueAccent,
                          padding: EdgeInsets.only(top: 10, left: 30, bottom: 10, right: 30),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          onPressed: () {},
                          child: Text("Compartir punto de interes", style: TextStyle(
                            color: Colors.white,
                          ),),
                        )
                      ],
                    )
                ),
              ),
            )
          ],
        )
    );
    }
  }