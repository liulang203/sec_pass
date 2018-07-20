import 'dart:async';
import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sec_pass/models/sec_account.dart';
/// database helper  for Security Account
class DbHelper {
  static final DbHelper _instance = new DbHelper.internal();

  factory DbHelper() => _instance;
  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DbHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "main.db");
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute("""CREATE TABLE $tableSecAccount(
      $columnId INTEGER PRIMARY KEY,
      $columnUsername TEXT,
      $columnTag TEXT,
      $columnPassword TEXT,
      $columnCreatedDate INTEGER,
      $columnUpdatedDate INTEGER,
      $columnAlternate1 TEXT,
      $columnAlternate2 TEXT,
      $columnAlternate3 TEXT,
      $columnAlternate4 TEXT,
      )""");
  }

  Future<int> saveSecAccount(SecAccount account) async {
    var dbClient = await db;
    int res = await dbClient.insert(tableSecAccount, account.toMap());
    return res;
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    int res = await dbClient
        .delete(tableSecAccount, where: "$columnId = ?", whereArgs: [id]);
    return res;
  }

  Future<SecAccount> get(int id) async {
    var dbClient = await db;
    List<Map> maps = await dbClient
        .query(tableSecAccount, where: "$columnId = ?", whereArgs: [id]);
    if (maps.isNotEmpty) {
      return new SecAccount.fromMap(maps.first);
    }
    return null;
  }

  Future<List<SecAccount>> search(String condition) async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(tableSecAccount,
        where: "$columnUsername like ? or $columnTag like ?",
        whereArgs: [condition, condition]);
    return maps.map((m) => new SecAccount.fromMap(m)).toList(growable: false);
  }
  Future<List<SecAccount>> all() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(tableSecAccount);
    return maps.map((m) => new SecAccount.fromMap(m)).toList(growable: false);
  }

  Future<int> updatePassword(SecAccount account) async {
    var dbClient = await db;
    int res = await dbClient.update(
        tableSecAccount,
        {
          columnPassword: account.password,
          columnPassword: account.updatedDate.millisecondsSinceEpoch
        },
        where: "$columnId = ?",
        whereArgs: [account.id]);
    return res;
  }

  Future<List<int>> batchUpdatePassword(List<SecAccount> accounts) async {
    var dbClient = await db;
    var batch = dbClient.batch();
    accounts.forEach((account) => batch.update(
        tableSecAccount,
        {
          columnPassword: account.password,
          columnPassword: account.updatedDate.millisecondsSinceEpoch
        },
        where: "$columnId = ?",
        whereArgs: [account.id]));

    List<int> res = await batch.commit();
    return res;
  }
}
