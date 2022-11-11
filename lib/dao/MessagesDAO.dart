import 'package:sqflite/sqflite.dart';

import '../dto/MessagesDTO.dart';

class MessagesDAO{
  MessagesDAO._();
  static final MessagesDAO db = MessagesDAO._();
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDB();
    return _database!;
  }

  initDB() async {
    return await openDatabase("messages.db",
        version: 1,
        onCreate: (db, version) async {
          // Create the note table
          await db.execute("create table messages("
              "seq integer primary key autoincrement, "
              "writer text not null,"
              "message text not null, "
              "write_date timestamp default(strftime('%s','now')||substr(strftime('%f','now'),4)) not null)"
          );
        });
  }

  Future<int> insert(MessagesDTO dto) async {
    final db = await database;
    var result = db.insert("messages", dto.toMap());
    //var result = db.rawInsert("insert into accounts (site,id,pw) values('${dto.site}','${dto.id}','${dto.pw}')");
    return result;
  }

  Future<List<MessagesDTO>> list() async{
    final db = await database;
    List<Map<String,dynamic>> result = await db.query("accounts");
    return result.isNotEmpty ? result.map((e) => MessagesDTO.fromDatabaseJson(e)).toList() : [];
  }

}