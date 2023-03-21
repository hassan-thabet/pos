import 'dart:developer';

import 'package:sqflite/sqflite.dart';
late Database database;

class DatabaseHelper {

  void createDatabase() async {
    database = await openDatabase(
      'uptimecode.db',
      version: 1,
      onCreate: (database , version) async {
        await database.execute('CREATE TABLE groups (id INTEGER PRIMARY KEY, name TEXT)');
        await database.execute('CREATE TABLE items (id INTEGER PRIMARY KEY, group_id INTEGER, code INTEGER, name TEXT, price INTEGER, stock INTEGER, image TEXT)');
        log('database created');
      },
      onOpen: (database){
        log('database opened');
      },
    );
  }

  void insertGroup(String groupName){
    database.transaction((txn) async {
      int id1 = await txn.rawInsert(
          'INSERT INTO groups(name) VALUES("$groupName")');
      log('inserted successfully: id : $id1 - name : $groupName');

    }
    );
  }
  Future<List<Map>> getGroups() async {
    return await database.rawQuery('SELECT * FROM groups');
  }
  void deleteGroup(int id) async {
    await database.rawDelete('DELETE FROM groups WHERE id = ?', [id]);
  }


  void insertItem(String name , image , int price , stock , code , groupId){
    database.transaction((txn) async {
      int id1 = await txn.rawInsert(
          'INSERT INTO items(group_id, code, name, price, stock, image) VALUES($groupId , $code , "$name" , $price , $stock , "$image")');
      log('inserted successfully => id : $id1 \n- name : $name \n- code : $code \n- price : $price \n- available $stock in stock \n- image url : $image');

      }
    );
  }

  Future<List<Map>> getItems() async {
    return await database.rawQuery('SELECT * FROM items');
  }
  void deleteItem(int id) async {
    await database.rawDelete('DELETE FROM items WHERE id = ?', [id]);
  }

  void updateItem(int groupId ,int code ,int price ,int stock ,int id ,String name , String image) async {
    await database.rawUpdate(
        'UPDATE items SET group_id = ?, code = ?, name = ?, price = ?, stock = ?, image = ? WHERE id = ?',
        ["$groupId", "$code", name, price, stock, image, id]);
  }
}