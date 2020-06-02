import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DonneesVides extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Center(
      child: new Text("Aucune données n'est présente",
      textScaleFactor: 2.5,
      textAlign: TextAlign.center,
      style: new TextStyle(
        color: Colors.red,
        fontStyle: FontStyle.italic
      ),),

    );
  }

}