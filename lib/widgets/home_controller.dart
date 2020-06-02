import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jeveux/model/databaseClient.dart';
import 'package:jeveux/model/item.dart';
import 'package:jeveux/widgets/donnees_vides.dart';

class HomeController extends StatefulWidget {
  HomeController({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeControllerState createState() => _HomeControllerState();
}

class _HomeControllerState extends State<HomeController> {
  String nouvelListe;
  List<Item> items = null;

  @override
  void initState() {
    super.initState();
    recuperer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            new FlatButton(onPressed: ajouter, child: new Text("Ajouter", style:new TextStyle(color: Colors.white)))
          ],
          title: Text(widget.title),
        ),
        body: (items==null || items.length==0)
            ? new DonneesVides()
            : new ListView.builder(
            itemCount: items.length,
            itemBuilder: (context,i){
              Item item = items[i];
              return new ListTile(
                title: new Text(item.nom),
                trailing: new IconButton(
                    icon: new Icon(Icons.delete),
                    onPressed: (){
                      DatabaseClient().delete(item.id, 'item').then((int){
                        print("L'int récupéré est : $int");
                        recuperer();
                      });
                    }),
              );
            }
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
                if(nouvelListe != null){
                  Map<String, dynamic> map ={'nom': nouvelListe};
                  Item item = new Item();
                  item.fromMap(map);
                  DatabaseClient().ajoutItem(item).then((i) => recuperer());
                  nouvelListe = null;
                }
                Navigator.pop(buildContext);
              }, child: new Text('Valider',style: new TextStyle(color: Colors.blue),))
            ],
          );
        }
    );
  }

  recuperer(){
    DatabaseClient().allItem().then((items){
      setState(() {
        this.items = items;
      });
    });
  }
}