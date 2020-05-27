
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:savemoney/database/model.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;

import 'goalmodel.dart';

class DBHelper {
  static Database _db;
  static const String ID = 'id';
  static const String NAME = 'name';
  static const String AMOUNT = 'amount';
  static const String TYPE = 'type';
  static const String ICON = 'icon';
  static const String DATE = 'date';
  static const String DESCRIPTION = 'description';

  static const String TOTAL = 'total';
  static const String CURRENT = 'current';
  static const String DATEFINISH = 'dateFinish';
  static const String TABLE = 'testDB';
  static const String TABLEGOAL = 'testDBGoal';
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
    await db.execute("CREATE TABLE $TABLEGOAL ($ID INTEGER PRIMARY KEY, $NAME TEXT, $TYPE TEXT, $TOTAL DOUBLE, $CURRENT DOUBLE, $ICON TEXT, $DESCRIPTION TEXT, $DATEFINISH TEXT)");
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
    Future<List<GoalModel>> getGoals() async {
    var dbClient = await db;
    final List<Map<String, dynamic>> maps = await dbClient.query(TABLEGOAL);
    return List.generate(maps.length, (index) {
      return GoalModel(
        id: maps[index]['id'],
        name: maps[index]['name'],
        type: maps[index]['type'],
        total: maps[index]['total'],
        icon: maps[index]['icon'],
        current: maps[index]['current'],
        dateFinish: maps[index]['dateFinish'],
        description: maps[index]['description'],
      );
    });
  }

  Future<List<EventModel>> getToDay() async {
    var dbClient = await db;
    var sql = "SELECT * FROM $TABLE WHERE $DATE LIKE '2020%' ";
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

  Future<GoalModel> insertGoals(GoalModel goalModel) async {
    print('insert');
    var dbClient = await db;
    goalModel.id = await dbClient.insert(
      TABLEGOAL, 
      goalModel.toMap(), 
      conflictAlgorithm: ConflictAlgorithm.replace
    );
    return goalModel;
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
  }

  Future<int> deleteGoal(int id) async {
    var dbClient = await db;
    // await dbClient.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
    return await dbClient.delete(TABLEGOAL, where: '$ID = ?', whereArgs: [id]);
  }

  Future<int> update(EventModel eventModel) async {
    var dbClient = await db;
    return await dbClient.update(TABLE, eventModel.toMap(),
      where: '$ID = ?', whereArgs: [eventModel.id]
    );
  }

  Future<int> updateGoal(GoalModel goalModel) async {
    var dbClient = await db;
    EventModel e = EventModel(
      name: goalModel.name, 
      type: goalModel.type, 
      icon: goalModel.icon, 
      amount: goalModel.current, 
      date: DateTime.now().toString(),
      description: goalModel.description
    );
    await dbClient.insert(TABLE, e.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
    return await dbClient.update(TABLEGOAL, 
      goalModel.toMap(),
      where: "id = ?",
      whereArgs: [goalModel.id]
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
    double goals = 0;
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
    var sqlGoals = "SELECT * FROM $TABLE WHERE $TYPE = 'goals'";
    final List<Map<String, dynamic>> mapsGoal = await dbClient.rawQuery(sqlGoals);
    for (var item in mapsGoal) {
      goals = goals + item['amount'];
    }
    print(income-expenditure- goals);
    return income-expenditure-goals;
  }
  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}