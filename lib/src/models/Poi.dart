class Poi {
  String id;
  String nombreEs;
  String nombreEn;
  String nombreCa;
  String informacionEs;
  String informacionEn;
  String informacionCa;
  String direccion;
  String longitud;
  String latitud;
  String codigo;
  String direccionBarrio;
  String direccionNumero;
  String urlInfo;
  String image;

  Poi(
      {this.id,
        this.nombreEs,
        this.nombreEn,
        this.nombreCa,
        this.informacionEs,
        this.informacionEn,
        this.informacionCa,
        this.direccion,
        this.longitud,
        this.latitud,
        this.codigo,
        this.direccionBarrio,
        this.direccionNumero,
        this.urlInfo,
        this.image});

  Poi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombreEs = json['nombre_es'];
    nombreEn = json['nombre_en'];
    nombreCa = json['nombre_ca'];
    informacionEs = json['informacion_es'];
    informacionEn = json['informacion_en'];
    informacionCa = json['informacion_ca'];
    direccion = json['direccion'];
    longitud = json['longitud'];
    latitud = json['latitud'];
    codigo = json['codigo'];
    direccionBarrio = json['direccion_barrio'];
    direccionNumero = json['direccion_numero'];
    urlInfo = json['url_info'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nombre_es'] = this.nombreEs;
    data['nombre_en'] = this.nombreEn;
    data['nombre_ca'] = this.nombreCa;
    data['informacion_es'] = this.informacionEs;
    data['informacion_en'] = this.informacionEn;
    data['informacion_ca'] = this.informacionCa;
    data['direccion'] = this.direccion;
    data['longitud'] = this.longitud;
    data['latitud'] = this.latitud;
    data['codigo'] = this.codigo;
    data['direccion_barrio'] = this.direccionBarrio;
    data['direccion_numero'] = this.direccionNumero;
    data['url_info'] = this.urlInfo;
    data['image'] = this.image;
    return data;
  }
}