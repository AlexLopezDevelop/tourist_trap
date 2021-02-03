import 'dart:async';
import 'dart:convert';

import 'package:tourist_trap/src/models/Pois.dart';
import 'package:tourist_trap/src/models/TypeData.dart';

import '../models/PoiData.dart';
import 'package:http/http.dart' as http;

class Api {
  String path = "https://shared.dribbalabs.com/salle/touristTrap/";

  Future<List<Pois>> fetchPois() async {
    List<Pois> aux;
    var response = await http.get(path + 'poi.json');
    if (response.statusCode == 200) {
      Map contentMap = jsonDecode(response.body);
      var content = PoiData.fromJson(contentMap);
      aux = content.pois;
    }
    return aux;
  }

  Future<List<POIType>> fetchTypes() async {
    List<POIType> aux;
    var response = await http.get(path + 'poi_type.json');
    if (response.statusCode == 200) {
      Map contentMap = jsonDecode(response.body);
      var content = TypeData.fromJson(contentMap);
    }
    return aux;
  }
}