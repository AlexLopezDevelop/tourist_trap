import 'Poi.dart';
import 'Status.dart';
import 'Type.dart';

class Pois {
  Poi poi;
  Status status;
  Type type;

  Pois({this.poi, this.status, this.type});

  Pois.fromJson(Map<String, dynamic> json) {
    poi = json['poi'] != null ? new Poi.fromJson(json['poi']) : null;
    status =
    json['status'] != null ? new Status.fromJson(json['status']) : null;
    type = json['type'] != null ? new Type.fromJson(json['type']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.poi != null) {
      data['poi'] = this.poi.toJson();
    }
    if (this.status != null) {
      data['status'] = this.status.toJson();
    }
    if (this.type != null) {
      data['type'] = this.type.toJson();
    }
    return data;
  }
}