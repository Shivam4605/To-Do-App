import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class HelperDatabase {
  // this method is used to create the Database into the selected devices and return the instance of the Database

  Future<Database> createDB() async {
    Database database = await openDatabase(
      join(await getDatabasesPath(), "TodoinfoDB.db"),
      version: 1,
      onCreate: (db, version) async {
        db.execute('''
            create table todoinfo(
             id integer primary key autoincrement,
             title text,
             description text,
             date text,
             iscompletedcheckbox integer
            )
          ''');
      },
    );
    return database;
  }

  // this method is used to Fetch the Data into the Database
  ///[getdata]
  Future<List<Map>> getTodoData() async {
    Database localDB = await createDB();
    List<Map> list = await localDB.query("todoinfo");
    return list;
  }

  // this method is used to insert the data into the Database
  ///[insertData] for
  void insertData(Map<String, dynamic> obj) async {
    Database localDB = await createDB();
    await localDB.insert(
      "todoinfo",
      obj,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // this method is used to update the Data into the Database
  ///[updatedata]
  Future<void> updatedata(Map<String, dynamic> obj) async {
    Database localDB = await createDB();
    await localDB.update(
      "todoinfo",
      obj,
      where: "id=?",
      whereArgs: [obj['id']],
    );
  }

  // this method is used to delete the data into the Database
  ///[deletedata]
  Future<void> deletedata(int id) async {
    Database localDB = await createDB();
    await localDB.delete("todoinfo", where: "id=?", whereArgs: [id]);
  }
}
