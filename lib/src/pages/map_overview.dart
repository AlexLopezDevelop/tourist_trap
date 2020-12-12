import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapOverview extends StatefulWidget {
  _MapOverview createState() => new _MapOverview();
}

class _MapOverview extends State<MapOverview> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962), zoom: 14.5);
  @override
  Widget build(BuildContext context) {
    Set<Marker> _markers = {};
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);

          setState(() {
            _markers.add(Marker(
                markerId: MarkerId('marker'),
                position: LatLng(37.42796133580664, -122.085749655962)));
          });
        },
        mapType: MapType.normal,
        markers: _markers,
        zoomGesturesEnabled: true,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}
