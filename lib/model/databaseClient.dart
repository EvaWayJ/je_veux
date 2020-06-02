import 'dart:async';
import 'dart:io';

import 'package:jeveux/model/item.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
class DatabaseClient{
  Database _database;

  Future<Database> get database async{
    if(_database != null){
      return _database;
    } else {
      _database = await create();
      return _database;
    }
  }

  Future create() async{
    Directory directory = await getApplicationDocumentsDirectory();
    String database_directory = directory.path+ 'database.db';
    var bdd = await openDatabase(database_directory, version: 1, onCreate:_onCreate );
    return bdd;
  }

  Future _onCreate(Database db, int version)async{
    await db.execute('''
    CREATE TABLE item (id INTEGER PRIMARY KEY, nom TEXT NOT NULL)
    ''');
  }

  /*ECRITURE DES DONNEES*/

  Future<Item> ajoutItem(Item item) async{
    Database maDatabase = await database;
    item.id = await maDatabase.insert('item',item.toMap());
    return item;
  }
  Future <int> update(Item item)async{
    Database maDatabase = await database;
    return await maDatabase.update('item', item.toMap(),where: 'id = ?', whereArgs: [item.id] );
  }

  Future <Item> upsertItem(Item item)async {
    Database maDatabase = await database;
    if (item.id == null) {
      item.id = await maDatabase.insert('item', item.toMap());
    } else {
      await maDatabase.update(
          'item', item.toMap(), where: 'id = ?', whereArgs: [item.id]);
    }
    return item;
  }


Future <int> delete(int id, String table)async{
    Database maDatabase = await database;
    return await maDatabase.delete(table, where: 'id = ?', whereArgs: [id]);
}

  /*lecture des donnees*/

  Future<List<Item>> allItem() async {
    Database maDatabase = await database;
    List<Map<String, dynamic>> resultat = await maDatabase.rawQuery('SELECT * FROM item');
    List<Item> items = [];
    resultat.forEach((map){
      Item item = new Item();
      item.fromMap(map);
      items.add(item);
    });
    return items;
  }
}