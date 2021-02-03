import 'package:flutter/material.dart';
import 'package:tourist_trap/src/models/TypeData.dart';

class ModalTypes extends StatelessWidget {
  final TypesData types;

  ModalTypes({Key key, @required this.types}) : super(key: key);

  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
        Widget>[
      Container(
        margin: EdgeInsets.only(top: 20, left: 10),
        child: Text("Filtra por puntos de interes",
            style: TextStyle(fontSize: 18)),
      ),
      Container(
        height: 110.0,
        margin: EdgeInsets.only(bottom: 20.0),
        child: Expanded(
          child: Container(
            margin: EdgeInsets.only(top: 25.0),
            child:
            ListView.builder(
                itemCount: types.typeData.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    width:  MediaQuery.of(context).size.width /  types.typeData.length,
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10),
                            width: 50.0,
                            height: 50.0,
                            decoration: new BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Text(types.typeData[index].pOIType.tipoEs, style: TextStyle(fontSize: 14)),
                      ],
                    ),);
                })
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 20, left: 10),
        child: Text("Modifica el tipo de mapa", style: TextStyle(fontSize: 18)),
      ),
      Container(
        height: 120.0,
        margin: EdgeInsets.only(bottom: 20.0),
        child: Expanded(
          child: Container(
            margin: EdgeInsets.only(top: 25.0),
            child:
                ListView(scrollDirection: Axis.horizontal, children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 3,
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        width: 50.0,
                        height: 50.0,
                        decoration: new BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Text("Predeterminado", style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 3,
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        width: 50.0,
                        height: 50.0,
                        decoration: new BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Text("Satelite", style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 3,
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        width: 50.0,
                        height: 50.0,
                        decoration: new BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Text("Relieve", style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    ]);
  }
}
