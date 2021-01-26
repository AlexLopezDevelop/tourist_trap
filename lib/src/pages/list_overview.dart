import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ListOverview extends StatefulWidget {
  ListOverview({Key key}) : super(key: key);

  @override
  _ListOverview createState() => _ListOverview();
}

class _ListOverview extends State<ListOverview> {
  List items = ["1", "2"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 60.0,
            child: Expanded(child: Container(
              margin: EdgeInsets.only(top: 25.0),
              child: ListView(scrollDirection: Axis.horizontal, children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      print("Container clicked");
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 5.0, right: 5.0),
                      padding: EdgeInsets.only(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0),
                      height: 10.0,
                      decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Text("Ordenar Alfabeticamente"),
                ),),
                GestureDetector(
                  onTap: (){
                    print("Container clicked");
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 5.0, right: 5.0),
                    padding: EdgeInsets.only(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0),
                    height: 10.0,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: Text("Por distancia"),
                  ),),
                GestureDetector(
                  onTap: (){
                    print("Container clicked");
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 5.0, right: 5.0),
                    padding: EdgeInsets.only(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0),
                    height: 10.0,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: Text("Por tipo"),
                  ),),
              ]),),),
          ),
          Expanded(child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return getCard();
              }),)
        ],
      ),
    );
  }

  Widget getCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: ListTile(
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: <Widget>[
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(60 / 2),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "https://images.unsplash.com/photo-1590846406792-0adc7f938f1d?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=632&q=80"))),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Punto de interes",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Calle torrent del Olla 218",
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    )
                  ],
                )
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  width: 20,
                  height: 20,
                  child: SvgPicture.asset("assets/icons/walking-icon.svg"),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 5,
                    right: 15,
                  ),
                  child: Text(
                    "150m",
                    style: TextStyle(fontSize: 12, color: Color(0xff3c5cdc)),
                  ),
                ),
                Container(
                  width: 10,
                  height: 10,
                  child: SvgPicture.asset("assets/icons/next-icon.svg"),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
