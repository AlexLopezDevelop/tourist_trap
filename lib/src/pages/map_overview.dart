import 'dart:collection';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tourist_trap/src/components/modal_detail_poi.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tourist_trap/src/models/Pois.dart';
import 'package:tourist_trap/src/tools/Tool.dart';
import '../api/Api.dart';
import 'package:geolocator/geolocator.dart';

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
  bool is_map_overview;
  TextEditingController controller = new TextEditingController();
  List<Pois> _searchResult = [];
  List<Pois> pois;
  LatLng _center ;
  double userLatitude;
  double userLongitude;

  @override
  void initState() {
    super.initState();
    markers = Set.from([]);
    is_map_overview = true;
  }


  getUserLocation() async {
    var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var lastPosition = await Geolocator.getLastKnownPosition();
    print(lastPosition);
    setState(() {
      userLatitude = position.latitude;
      userLongitude = position.longitude;
    });
  }

  createMarker(List<Pois> poi, int index) {
    /*if (customIcon == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(
              configuration, 'assets/icons/marker-icon.png')
          .then((icon) {
        setState(() {
          customIcon = icon;*/
          _markers.add(
            Marker(
                markerId: MarkerId(index.toString()),
                position: LatLng(double.parse(poi[index].poi.latitud), double.parse(poi[index].poi.longitud)),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueAzure),
                onTap: () {
                  _showModalBottom(poi[index]);
                }),
          );
        /*});
      });
    }*/
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

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    pois.forEach((poi) {
      if (poi.poi.nombreEn.toLowerCase().contains(text.toLowerCase()))
        _searchResult.add(poi);
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Api().fetchPois(),
      builder: (_, snapshot) {
        if (snapshot.connectionState ==
            ConnectionState.waiting) {
          return SafeArea(child: Scaffold(body: Center(
            child: Text("Loading..."),
          ),));
        } else {
          pois = snapshot.data;

          _markers.clear();

          if (_searchResult.length != 0 || controller.text.isNotEmpty) {
            for (int i = 0; i < _searchResult.length; i++) {
              createMarker(_searchResult, i);
            }

          } else {

            for (int i = 0; i < pois.length; i++) {
              createMarker(pois, i);
            }
          }




          return SafeArea(
              child: is_map_overview
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
                          onPressed: () {getUserLocation();},
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
                          // TODO: Change hardcoded coordinates by user coordinates
                          target: _center != null ? _center : LatLng(41.403706, 2.173504),
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
                                  controller: controller,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Busca tu lugar favorito"),
                                    onChanged: onSearchTextChanged,
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
                              is_map_overview = false;
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
                              controller: controller,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Busca tu lugar favorito"),
                              onChanged: onSearchTextChanged,
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
                                    pois.sort((a, b) => a.poi.nombreEn.compareTo(b.poi.nombreEn));
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
                                    pois.sort((a, b) => a.poi.latitud.compareTo(b.poi.latitud));
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
                                    pois.sort((a, b) => a.type.id.compareTo(b.type.id));
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
                        child: _searchResult.length != 0 || controller.text.isNotEmpty ?
                          ListView.builder(
                              itemCount: _searchResult.length,
                              itemBuilder: (context, index){
                                return getCard(_searchResult[index]);
                              })
                        : ListView.builder(
                            itemCount: pois.length,
                            itemBuilder: (context, index) {
                              return getCard(pois[index]);
                            }),),
                    Container(
                      alignment: Alignment.bottomCenter,
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.white)),
                        onPressed: () {
                          setState(() {
                            is_map_overview = true;
                          });
                        },
                        color: Colors.white,
                        textColor: Colors.black,
                        child: Text("Ver mapa", style: TextStyle(fontSize: 14)),
                      ),
                    ),
                  ],
                ),
              ));
        }
      },
    );
  }

  _showModalBottom(Pois poi) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return ModalMapDetail(poi: poi,);
        });
  }

  Widget getCard(Pois poi) {
    // TODO: Change hardcoded coordinates by user coordinates
    var distanceFromPoi = Geolocator.distanceBetween( 37.77483, -122.41942, double.parse(poi.poi.latitud), double.parse(poi.poi.longitud));

    return GestureDetector(
      child: Card(
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
                            style: TextStyle(color: Colors.grey, fontSize: 13),
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
      onTap: () => _showModalBottom(poi),
    );
  }
}
