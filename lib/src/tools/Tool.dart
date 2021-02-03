import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tourist_trap/src/components/modal_detail_poi.dart';
import 'package:tourist_trap/src/components/modal_types.dart';
import 'package:tourist_trap/src/models/Pois.dart';
import 'package:tourist_trap/src/models/TypeData.dart';

class Tool {
  String distanceCalculator(double distance) {
    if (distance.toString().length > 3) {
      distance = double.parse(distance.toString()) / 1000;
      return distance.roundToDouble().toString() + " km";
    }

    return distance.roundToDouble().toString() + " m";
  }

  showModalBottomMapDetail(Pois poi, context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return ModalMapDetail(
            poi: poi,
          );
        });
  }

  showModalBottomTypes(TypesData types, context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return ModalTypes(types: types );
        });
  }

  Future<Position> getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }

    return await Geolocator.getCurrentPosition();
  }
}
