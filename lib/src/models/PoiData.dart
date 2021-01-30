import 'Pois.dart';

class PoiData {
  String status;
  String hora;
  List<Pois> pois;

  PoiData({this.status, this.hora, this.pois});

  PoiData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    hora = json['hora'];
    if (json['pois'] != null) {
      pois = new List<Pois>();
      json['pois'].forEach((v) {
        pois.add(new Pois.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['hora'] = this.hora;
    if (this.pois != null) {
      data['pois'] = this.pois.map((v) => v.toJson()).toList();
    }
    return data;
  }
}