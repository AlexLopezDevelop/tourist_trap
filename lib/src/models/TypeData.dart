class TypesData {
  List<TypeData> typeData;

  TypesData({this.typeData});

  TypesData.fromJson(List<dynamic> json) {
    if (json != null) {
      typeData = new List<TypeData>();
      json.forEach((v) {
        typeData.add(new TypeData.fromJson(v));
      });
    }
  }
}

class TypeData {
  POIType pOIType;

  TypeData({this.pOIType});

  TypeData.fromJson(Map<String, dynamic> json) {
    pOIType =
    json['POIType'] != null ? new POIType.fromJson(json['POIType']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pOIType != null) {
      data['POIType'] = this.pOIType.toJson();
    }
    return data;
  }
}

class POIType {
  String id;
  String tipoEs;
  String tipoEn;
  String tipoCa;
  String explicacionEs;
  String explicacionEn;
  String explicacionCa;

  POIType(
      {this.id,
        this.tipoEs,
        this.tipoEn,
        this.tipoCa,
        this.explicacionEs,
        this.explicacionEn,
        this.explicacionCa});

  POIType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tipoEs = json['tipo_es'];
    tipoEn = json['tipo_en'];
    tipoCa = json['tipo_ca'];
    explicacionEs = json['explicacion_es'];
    explicacionEn = json['explicacion_en'];
    explicacionCa = json['explicacion_ca'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tipo_es'] = this.tipoEs;
    data['tipo_en'] = this.tipoEn;
    data['tipo_ca'] = this.tipoCa;
    data['explicacion_es'] = this.explicacionEs;
    data['explicacion_en'] = this.explicacionEn;
    data['explicacion_ca'] = this.explicacionCa;
    return data;
  }
}