import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Je veux...'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
String nouvelListe;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          new FlatButton(onPressed: ajouter, child: new Text("Ajouter", style:new TextStyle(color: Colors.white)))
        ],
        title: Text(widget.title),
      ),
      body: Center(
      ));
  }

  Future<Null> ajouter()async{
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext buildContext){
        return new AlertDialog(
          title: new Text('Ajouter une liste de souhaits'),
          content: new TextField(
            decoration: new InputDecoration(
              labelText: "liste:",
              hintText: "ex: mes prochains jeu video"
            ),
            onChanged: (String str){
              nouvelListe=str;
            },
          ),
          actions: <Widget>[
            new FlatButton(onPressed: (()=> Navigator.pop(buildContext)), child: new Text('Annuler')),
            new FlatButton(onPressed: (){
              Navigator.pop(buildContext);
            }, child: new Text('Valider',style: new TextStyle(color: Colors.blue),))
          ],
        );
      }
    );
  }
}
