class Status {
  String estadoEs;
  String estadoEn;
  String estadoCa;

  Status({this.estadoEs, this.estadoEn, this.estadoCa});

  Status.fromJson(Map<String, dynamic> json) {
    estadoEs = json['estado_es'];
    estadoEn = json['estado_en'];
    estadoCa = json['estado_ca'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['estado_es'] = this.estadoEs;
    data['estado_en'] = this.estadoEn;
    data['estado_ca'] = this.estadoCa;
    return data;
  }
}