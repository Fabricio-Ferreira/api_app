import 'package:flutter/material.dart';
import 'package:sw_app/ui/homePage.dart';

void main(){

  // CRIANDO A FUNÇÃO MAIN 
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      hintColor: Colors.amber,
      primaryColor: Colors.white
    ),
    home: HomePage(),
  ));
}


