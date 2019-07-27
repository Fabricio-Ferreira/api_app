import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:sw_app/alerts/alertsDialogs.dart';
import 'dart:convert';
import 'package:sw_app/ui/people.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _search;

  // FUNÇÃO _GETPEOPLE QUE FAZ A CONSULTA JSON NA API
  Future<List<People>> _getPeople() async {

    http.Response data;

    if(_search == null || _search.isEmpty)
      data = await http.get('https://swapi.co/api/people/?page=1');
    else
      data = await http.get('https://swapi.co/api/people/?page=$_search');
    // ignore: unrelated_type_equality_checks
    if(_search == 9){
      data = await http.get('https://swapi.co/api/people/?page=$_search');
      for(int index = 0; index <= 9; index++){
        print(json.decode(data.body)["results"][index]["name"]);}
    } 

    var jsonData = (json.decode(data.body)["results"]);

    List<People> peoples = [];

    for (var p in jsonData) {

      People people = People(
        p["name"], p["height"], p["mass"], p["hair_color"],
        p["skin_color"], p["eye_color"], p["birth_year"], p["gender"]);

        peoples.add(people);
    }
      print(peoples.length);

      return peoples;
  }

  // VALIDAÇÃO DA VARIAVEL _SEARCH
  void _validateSearch(){
   if(int.parse(_search) > 9){
      showAlertDialog(context);
    }
}

// TELA PRINCIPAL DO APLICATIVO DE API STAR WARS
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Text("SWAPI - The Star Wars API"),
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
              keyboardType: TextInputType.number, maxLength: 1,
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: _getPeople(),
              builder: (BuildContext context, AsyncSnapshot snapshot){
                if (snapshot.data == null) {
                    return Container(
                      child: Center(
                        child: Text("Loading"),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index){
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage("images/starwars.png")
                          ),
                          title: Text("Nome: " + snapshot.data[index].name,
                                      style: TextStyle(color: Colors.white,
                                      fontSize: 18.0,)),
                          subtitle: Text("Genero: "+snapshot.data[index].gender,
                                      style: TextStyle(color: Colors.amber,
                                      fontSize: 14.0),),
                          onTap: (){
                            Navigator.push(context,
                              new MaterialPageRoute(builder: (context) => DetailsPage(snapshot.data[index])));
                            },
                        );
                      },
                    );
                  }}
            ),
          )
        ],
      ),
    );
  }
}

// PAGINA DE DETALHES DOS PERSONAGENS STAR WARS
class DetailsPage extends StatelessWidget {
  DetailsPage(this.people);

  final People people;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Text(people.name),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Altura: " + people.height +
            "\n\nPeso: " + people.mass +
            "\n\nCor do Cabelo: " + people.hair_color +
            "\n\nCor da Pele: " + people.skin_color +
            "\n\nCor do Olho: " + people.eye_color +
            "\n\nAno de Nascimento: " + people.birth_year ,
            style: TextStyle(color: Colors.amber,
                                      fontSize: 24.0)),
          )
        ),
      );
  }
}

