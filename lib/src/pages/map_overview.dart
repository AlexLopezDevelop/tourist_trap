import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapOverview extends StatefulWidget {
  MapOverview({Key key}) : super(key: key);

  @override
  _MapOverview createState() => _MapOverview();
}

class _MapOverview extends State<MapOverview> {
  Set<Marker> _markers = HashSet<Marker>();


  GoogleMapController _mapController;
  BitmapDescriptor _markerIcon;
  MapType _viewMapType = MapType.normal;

  @override
  void initState() {
    super.initState();
    _setMarkerIcon();
  }

  void _setMarkerIcon() async {
    _markerIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/noodle_icon.png');
  }

  void _toggleMapStyle() async {

    setState(() {
      _viewMapType = _viewMapType == MapType.normal
          ? MapType.satellite : _viewMapType == MapType.satellite
          ? MapType.hybrid : _viewMapType == MapType.hybrid ? MapType.terrain :
          MapType.normal;
    });



  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    setState(() {
      _markers.add(
        Marker(
            markerId: MarkerId("0"),
            position: LatLng(37.77483, -122.41942),
            infoWindow: InfoWindow(
              title: "San Francsico",
              snippet: "An Interesting city",
            ),
            icon: _markerIcon),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(37.77483, -122.41942),
              zoom: 12,
            ),
            markers: _markers,
            mapType: _viewMapType,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
          ),
          Positioned(
            top: 50,
            right: 15,
            left: 15,
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
                  borderRadius: BorderRadius.all(Radius.circular(25),)
              ),
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
              onPressed: () {},
              color: Colors.white,
              textColor: Colors.black,
              child: Text("Ver lista",
                  style: TextStyle(fontSize: 14)),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton:   Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {
                  _toggleMapStyle();
             },
              child: Icon(Icons.layers_outlined, color: Colors.black,),
            ),
            Container(width: 10, height: 10,),
            FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.location_searching),
            )
          ],
        ),
    );
  }
}
