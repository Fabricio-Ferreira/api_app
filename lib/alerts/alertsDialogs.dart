import 'package:flutter/material.dart';

showAlertDialog(BuildContext context)
{
    // configura o button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () { },
  );
  // configura o  AlertDialog
  AlertDialog alerta = AlertDialog(
    title: Text("Fique atento!"),
    content: Text("Você deve inserir somente de 1 a 9!"),
    actions: [
      okButton,
    ],
  );
  // exibe o dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alerta;
    },
  );
}

showAlertDialog2(BuildContext context) {
   Widget cancelaButton = FlatButton(
    child: Text("Cancelar"),
    onPressed:  () {
      Navigator.pop(context);
    },
  );
  Widget continuaButton = FlatButton(
    child: Text("Continar"),
    onPressed:  () {
      Navigator.pop(context);
      Navigator.pop(context);
    },
  );
  //configura o AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Alerta!"),
    content: Text("Deseja continuar aprendendo Flutter ?"),
    actions: [
      cancelaButton,
      continuaButton,
    ],
  );
  //exibe o diálogo
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}