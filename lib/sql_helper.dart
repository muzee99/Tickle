import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/foundation.dart';

const String tableName = 'breakdown';
const String tableCard = 'creditCard';
const String tableBreakdown = 'breakdown';
const String bmTableName = 'bookmark';
const String columnId = 'id';
const String columnContent = 'content';
const String columnIsDone = 'isDone';
const String columnCardName = 'cardName';
const String columnBankName = 'bankName';
const String columnBalance = 'balance';
const String columnCategory = 'cagegory';
const String columnPrice = 'price';
const String columnIsSpend = 'isSpend';
const String columnMethodID = 'methodID';
const String columnDate = 'date';

class Todo {
  late int? id;
  late String content;
  late int isDone;

  Todo({this.id, required this.content, required this.isDone});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      columnId: id,
      columnContent: content,
      columnIsDone: isDone,
    };
    return map;
  }

  Todo.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    content = map[columnContent];
    isDone = map[columnIsDone];
    debugPrint('$id, $content, $isDone');
  }
}

class CreditCard {
  late int? id;
  late String cardName;
  late String bankName;
  late int balance;

  CreditCard({this.id, required this.cardName, required this.bankName, required this.balance});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      columnId: id,
      columnCardName: cardName,
      columnBankName: bankName,
      columnIsDone: balance,
    };
    return map;
  }

  CreditCard.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    cardName = map[columnCardName];
    bankName = map[columnBankName];
    balance = map[columnBalance];
    debugPrint('$id, $cardName, $bankName, $balance');
  }
}

class Breakdown {
  late int? id;
  late String content;
  late DateTime date;
  late TimeOfDay time;
  late String category;
  late String tag;
  late int price;
  late int isSpend;
  late int methodID;

  Breakdown({this.id, required this.content, required this.category, required this.price, required this.isSpend, required this.methodID});

Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      columnId: id,
      columnCardName: content,
      columnBankName: category,
      columnPrice: price,
      columnIsSpend: isSpend,
      columnMethodID: methodID,
    };
    return map;
  }

  Breakdown.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    content = map[columnCardName];
    category = map[columnBankName];
    price = map[columnIsDone];
    isSpend = map[columnIsSpend];
    methodID = map[columnMethodID];
    debugPrint('$id, $content, $category, $price, $isSpend, $methodID');
  }
}

class DBProvider {
  late Database _database;

  Future<Database> get database async{
    _database = await initDB();
    return _database;
  }

  initDB() async {
    String path = join(await getDatabasesPath(), 'tickle_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE $tableCard(
          $columnId INTEGER PRIMARY KEY AUTOINCREMENT, 
          $columnCardName TEXT NOT NULL,
          $columnBankName TEXT NOT NULL,
          $columnBalance INTEGER NOT NULL
          )''',
        );
        await db.execute('''
          CREATE TABLE $tableBreakdown(
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT, 
            $columnContent TEXT NOT NULL,
            $columnCategory TEXT NOT NULL,
            $columnContent TEXT NOT NULL,
            $columnPrice INTEGER NOT NULL
            $columnIsSpend INTEGER NOT NULL
            $columnMethodID INTEGER NOT NULL
            )''',
        );
      },
      onUpgrade: (db, oldVersion, newVersion){}
    );

  }

  Future<void> insertTodo(Todo todo, String table) async {
    final db = await database;
    debugPrint("++++insertTodo++++");
    todo.id = await db.insert(table, todo.toMap());
  }

  Future<void> updateTodo(Todo todo, String table) async {
    final db = await database;
    debugPrint("++++updateTodo++++");
    await db.update(
      table, 
      todo.toMap(), 
      where: "$columnId = ?", 
      whereArgs: [todo.id],
    );
  }

  Future<void> deleteTodo(int? id, String table) async {
    debugPrint('++++deleteTodo++++');
    final db = await database;
    debugPrint("deleteTodo : $id");
    await db.delete(
      table,
      where: "$columnId = ?",
      whereArgs: [id],
    );
  }

  Future<List<Todo>> todoItems(String table) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(table);
    if(!maps.isNotEmpty) return [];
    return List.generate(maps.length, (index) {
      return Todo(
        id: maps[index][columnId],
        content: maps[index][columnContent],
        isDone: maps[index][columnIsDone],
      );
    });
  }
}