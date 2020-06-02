import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Ajout extends StatefulWidget{
  int id;
  
  Ajout(int id){
    this.id =id;
  }

  @override
  _AjoutState createState() => _AjoutState();
  
  
}

class _AjoutState extends State<Ajout>{
  
  String image;
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Ajouter'),
        actions: <Widget>[
          new FlatButton(onPressed: null, child: new Text('Valider', style: new TextStyle(color: Colors.white),))
        ],
      ),
      body: new SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: new Column(
          children: <Widget>[
            new Text('Article à ajouter', textScaleFactor: 1.4, style: TextStyle(color: Colors.red, fontStyle: FontStyle.italic),),
            new Card(
              elevation: 10.0,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  (image == null )? new Image.asset('image/no_image.png')
                  :new Image.file(new File(image)),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new IconButton(icon: new Icon(Icons.camera), onPressed: null),
                      new IconButton(icon: new Icon(Icons.photo_library), onPressed: null)
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  
}