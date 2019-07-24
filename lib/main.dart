import 'package:flutter/material.dart';
import 'package:sw_app/ui/homePage.dart';

void main(){

  //print(response.body);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      hintColor: Colors.amber,
      primaryColor: Colors.white
    ),
    home: HomePage(),
  ));
}


