import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sw_app/ui/people.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String _search;
  List<String> data;
  
  Future<Map> _getPeople() async {
    http.Response response;
    if(_search == null || _search.isEmpty)
      response = await http.get('https://swapi.co/api/people/?page=1');
    else
      response = await http.get('https://swapi.co/api/people/?page=$_search');
    // ignore: unrelated_type_equality_checks
    if(_search == 9){
      response = await http.get('https://swapi.co/api/people/?page=$_search');
      for(int index = 0; index < 7; index++){
        print(json.decode(response.body)["results"][index]["name"]);}
    }
    for(int index = 0; index < 10; index++) {
      print(json.decode(response.body)["results"][index]["name"]);

    }
    return data = json.decode(response.body);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Text("The Star Wars API"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                  labelText: "Pesquise aqui! - Digite 1 ao 9",
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder()
              ),
              style: TextStyle(color: Colors.white, fontSize: 18.0),
              textAlign: TextAlign.center,
              onSubmitted: (text){
                setState(() {
                  _search = text;
                });
              },
              keyboardType: TextInputType.number,
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: _getPeople(),
              builder: (context, snapshot){
                switch(snapshot.connectionState){
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                  case ConnectionState.done:
                    return Container(
                      width: 200.0,
                      height: 200.0,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 5.0,
                      ),
                    );
                  default:
                    if(snapshot.hasError) return Container();
                    else return createListPeople(context, snapshot);
                }}
            ),
          )
        ],
      ),
    );
  }
}

Widget createListPeople(BuildContext context, AsyncSnapshot snapshot){
  return ListView.builder(
      padding: EdgeInsets.all(10.0),
      itemCount: 10,
      itemBuilder: (BuildContext context, int index){
        return new Card(
          child: new Text(snapshot.data["data"].toString())
        );
      });
}
