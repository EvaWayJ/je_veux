import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jeveux/model/article.dart';
import 'package:jeveux/model/databaseClient.dart';
import 'package:jeveux/model/item.dart';
import 'package:jeveux/widgets/ajout_article.dart';
import 'package:jeveux/widgets/donnees_vides.dart';

class ItemDetail extends StatefulWidget{
  Item item;

  ItemDetail(Item item){
    this.item = item;
  }

  @override
  _ItemDetailState createState() => new _ItemDetailState();

}

class _ItemDetailState extends State<ItemDetail>{
  List<Article> articles;
@override
void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseClient().allArticles(widget.item.id).then((list){
      setState(() {
        articles = list;
      });
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: new Text(widget.item.nom),
        actions: <Widget>[
          new FlatButton(onPressed: (){
             Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
              return new Ajout(widget.item.id);
            })).then((value){
               DatabaseClient().allArticles(widget.item.id).then((list){
                 setState(() {
                   articles = list;
                 });
               });
            });
          }, child: new Text('ajouter', style: new TextStyle(color:  Colors.white),))
        ],),
      body: (articles == null || articles.length == 0)?
      new DonneesVides()
          : new GridView.builder(
          itemCount: articles.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
          itemBuilder: (context,i){
            Article article = articles[i];
            return new Card(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Text(article.nom),
                  new Container(
                    height: MediaQuery.of(context).size.height/2,
                    child: (article.image==null)?
                    new Image.asset("image/no_image.png")
                        : new Image.file(new File(article.image)),
                  ),
                      new Text((article.prix == null)?"Aucun prix renseigné": "Prix: ${article.prix}"),
                    new Text((article.magasin == null)?"Aucun magasin renseigné": "Magasin: ${article.magasin}")
                ],
              ),
            );
          }),
    );
  }

}