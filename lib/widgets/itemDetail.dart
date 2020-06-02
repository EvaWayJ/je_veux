import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jeveux/model/article.dart';
import 'package:jeveux/model/item.dart';
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
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: new Text(widget.item.nom),
        actions: <Widget>[
          new FlatButton(onPressed: null, child: new Text('ajouter', style: new TextStyle(color:  Colors.white),))
        ],),
      body: (articles == null || articles.length == 0)?
      new DonneesVides()
          : new GridView.builder(
          itemCount: articles.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context,i){
            Article article = articles[i];
            return new Card(
              child: new Column(
                children: <Widget>[
                  new Text(article.nom)
                ],
              ),
            );
          }),
    );
  }

}