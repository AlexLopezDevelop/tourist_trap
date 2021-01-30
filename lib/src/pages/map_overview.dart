import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tourist_trap/src/components/modal_detail_poi.dart';
import 'package:flutter_svg/svg.dart';

class MapOverview extends StatefulWidget {
  MapOverview({Key key}) : super(key: key);

  @override
  _MapOverview createState() => _MapOverview();
}

class _MapOverview extends State<MapOverview> {
  Set<Marker> _markers = HashSet<Marker>();
  MapType _viewMapType = MapType.normal;
  BitmapDescriptor customIcon;
  Set<Marker> markers;
  bool _is_map_overview;
  List items = ["1", "2"];

  @override
  void initState() {
    super.initState();
    markers = Set.from([]);
    _is_map_overview = true;
  }

  createMarker(context) {
    if (customIcon == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(
              configuration, 'assets/icons/marker-icon.png')
          .then((icon) {
        setState(() {
          customIcon = icon;
          _markers.add(
            Marker(
                markerId: MarkerId("0"),
                position: LatLng(37.77483, -122.41942),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueAzure),
                onTap: () => _showModalBottom()),
          );
        });
      });
    }
  }

  void _toggleMapStyle() async {
    setState(() {
      _viewMapType = _viewMapType == MapType.normal
          ? MapType.satellite
          : _viewMapType == MapType.satellite
              ? MapType.hybrid
              : _viewMapType == MapType.hybrid
                  ? MapType.terrain
                  : MapType.normal;
    });
  }

  @override
  Widget build(BuildContext context) {
    createMarker(context);
    return SafeArea(
        child: _is_map_overview
            ? Scaffold(
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.endFloat,
                floatingActionButton: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FloatingActionButton(
                      backgroundColor: Colors.white,
                      onPressed: () {
                        _toggleMapStyle();
                      },
                      child: Icon(
                        Icons.layers_outlined,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      width: 10,
                      height: 10,
                    ),
                    FloatingActionButton(
                      onPressed: () {},
                      child: Icon(Icons.location_searching),
                    )
                  ],
                ),
                body: Stack(
                  children: <Widget>[
                    // map_overview

                    GoogleMap(
                      onMapCreated: (GoogleMapController controller) {},
                      initialCameraPosition: CameraPosition(
                        target: LatLng(37.77483, -122.41942),
                        zoom: 12,
                      ),
                      markers: _markers,
                      mapType: _viewMapType,
                      myLocationEnabled: true,
                      mapToolbarEnabled: false,
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                    ),
                    Positioned(
                      top: 25,
                      right: 5,
                      left: 5,
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 15.0, // soften the shadow
                                spreadRadius: 0.5, //extend the shadow
                                offset: Offset(
                                  4.0, // Move to right 10  horizontally
                                  4.0, // Move to bottom 10 Vertically
                                ),
                              )
                            ],
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(25),
                            )),
                        child: Row(
                          children: <Widget>[
                            IconButton(
                              splashColor: Colors.grey,
                              icon: Icon(Icons.search),
                              onPressed: () {},
                            ),
                            Expanded(
                              child: TextField(
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.go,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Busca tu lugar favorito"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.white)),
                        onPressed: () {
                          setState(() {
                            _is_map_overview = false;
                          });
                        },
                        color: Colors.white,
                        textColor: Colors.black,
                        child:
                            Text("Ver lista", style: TextStyle(fontSize: 14)),
                      ),
                    ),
                  ],
                ))
            : Scaffold(
                body: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 25.0, left: 5.0, right: 5.0),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 15.0, // soften the shadow
                              spreadRadius: 0.5, //extend the shadow
                              offset: Offset(
                                4.0, // Move to right 10  horizontally
                                4.0, // Move to bottom 10 Vertically
                              ),
                            )
                          ],
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          )),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            splashColor: Colors.grey,
                            icon: Icon(Icons.search),
                            onPressed: () {},
                          ),
                          Expanded(
                            child: TextField(
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.go,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Busca tu lugar favorito"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 60.0,
                      margin: EdgeInsets.only(bottom: 20.0),
                      child: Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 25.0),
                          child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    print("Container clicked");
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.only(left: 5.0, right: 5.0),
                                    padding: EdgeInsets.only(
                                        top: 10.0,
                                        left: 20.0,
                                        bottom: 10.0,
                                        right: 20.0),
                                    height: 10.0,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Text("Ordenar Alfabeticamente"),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    print("Container clicked");
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.only(left: 5.0, right: 5.0),
                                    padding: EdgeInsets.only(
                                        top: 10.0,
                                        left: 20.0,
                                        bottom: 10.0,
                                        right: 20.0),
                                    height: 10.0,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Text("Por distancia"),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    print("Container clicked");
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.only(left: 5.0, right: 5.0),
                                    padding: EdgeInsets.only(
                                        top: 10.0,
                                        left: 20.0,
                                        bottom: 10.0,
                                        right: 20.0),
                                    height: 10.0,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Text("Por tipo"),
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return getCard();
                          }),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.white)),
                        onPressed: () {
                          setState(() {
                            _is_map_overview = true;
                          });
                        },
                        color: Colors.white, textColor: Colors.black,
                        child: Text("Ver mapa", style: TextStyle(fontSize: 14)),
                      ),
                    ),
                  ],
                ),
              ));
  }

  _showModalBottom() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return ModalMapDetail();
        });
  }

  Widget getCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10, top: 10.0),
        child: ListTile(
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
                          image: NetworkImage(
                              "https://images.unsplash.com/photo-1590846406792-0adc7f938f1d?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=632&q=80"))),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Punto de interes",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Calle torrent del Olla 218",
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    )
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
                    "150m",
                    style: TextStyle(fontSize: 12, color: Color(0xff3c5cdc)),
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
    );
  }
}
