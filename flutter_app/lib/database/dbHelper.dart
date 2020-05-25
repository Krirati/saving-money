
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:savemoney/database/model.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;

class DBHelper {
  static Database _db;
  static const String ID = 'id';
  static const String NAME = 'name';
  static const String AMOUNT = 'amount';
  static const String TYPE = 'type';
  static const String ICON = 'icon';
  static const String DATE = 'date';
  static const String DESCRIPTION = 'description';

  static const String TABLE = 'testDB';
  static const String DB_NAME = 'transaction_test.db';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY, $NAME TEXT, $TYPE TEXT, $AMOUNT DOUBLE, $ICON TEXT, $DESCRIPTION TEXT, $DATE TEXT)");
  }

  Future<List<EventModel>> getEvents() async {
    var dbClient = await db;
    final List<Map<String, dynamic>> maps = await dbClient.query(TABLE);
    return List.generate(maps.length, (index) {
      return EventModel(
        id: maps[index]['id'],
        name: maps[index]['name'],
        type: maps[index]['type'],
        amount: maps[index]['amount'],
        icon: maps[index]['icon'],
        date: maps[index]['date'],
        description: maps[index]['description'],
      );
    });
  }

  Future<EventModel> insert(EventModel eventModel) async {
    print('insert');
    var dbClient = await db;
    eventModel.id = await dbClient.insert(
      TABLE, 
      eventModel.toMap(), 
      conflictAlgorithm: ConflictAlgorithm.replace
    );
    return eventModel;
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
  }

  Future<int> update(EventModel eventModel) async {
    var dbClient = await db;
    return await dbClient.update(TABLE, eventModel.toMap(),
      where: '$ID = ?', whereArgs: [eventModel.id]
    );
  }

  Future<List<EventModel>> quertTypeEvent(String typeNew, String range) async{
    var dbClient = await db;
    var start = ' 00:00:01';
    var end = DateTime.now().toString() ;
    var sql;
    switch (range) {
      case 'month':
        sql = "SELECT * FROM $TABLE WHERE $TYPE = '$typeNew' AND $DATE BETWEEN $start AND $end ORDER BY $DATE DESC";
        break;
      case 'year':
        sql = "SELECT * FROM $TABLE WHERE $TYPE = '$typeNew' AND $DATE BETWEEN $start AND $end ORDER BY $DATE DESC";
        break;
      default: {
        sql = "SELECT * FROM $TABLE WHERE $TYPE = '$typeNew' AND $DATE ORDER BY $DATE DESC";
      }
    }
    // final List<Map<String, dynamic>> maps = await dbClient.query(TABLE, where: '$Type = ?', whereArgs: [eventModel.type], orderBy: eventModel.date);
    final List<Map<String, dynamic>> maps = await dbClient.rawQuery(sql);
    return List.generate(maps.length, (index) {
      return EventModel(
        id: maps[index]['id'],
        name: maps[index]['name'],
        type: maps[index]['type'],
        amount: maps[index]['amount'],
        icon: maps[index]['icon'],
        date: maps[index]['date'],
        description: maps[index]['description'],
      );
    });
  }

  Future<double> sumAll(String typeNew) async {
    var dbClient = await db;
    var sql = "SELECT * FROM $TABLE WHERE $TYPE = '$typeNew'";
    final List<Map<String, dynamic>> maps = await dbClient.rawQuery(sql);
    double amount = 0;
    for (var item in maps) {
      amount = amount + item['amount'];
    }
    return amount;
  }

  Future<double> balance() async {
    var dbClient = await db;
    double income = 0;
    double expenditure = 0;
    var sql = "SELECT * FROM $TABLE WHERE $TYPE = 'income'";
    final List<Map<String, dynamic>> mapsIn = await dbClient.rawQuery(sql);
    for (var item in mapsIn) {
      income = income + item['amount'];
    }
    var sqlEx = "SELECT * FROM $TABLE WHERE $TYPE = 'expenditure'";
    final List<Map<String, dynamic>> mapsEx = await dbClient.rawQuery(sqlEx);
    for (var item in mapsEx) {
      expenditure = expenditure + item['amount'];
    }
    print(income-expenditure);
    return income-expenditure;
  }
  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}