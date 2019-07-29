import 'package:async/async.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;
import 'todo.dart';
import 'package:path_provider/path_provider.dart';


class DBHelper{
  static Database _db;
  static const String ID = 'id';
  static const String NAME = 'name';
  static const String OVERVIEW = 'overview';
  static const String TABLE = 'Todo';
  static const String DB_NAME = 'todo.db';

  Future<Database> get db async{
    if(_db != null){
      return _db;
    }
    _db = await initDB();
    return _db;
  }

  initDB() async{
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

   _onCreate(Database db, int version) async {
      await db
          .execute("CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY, $NAME TEXT, $OVERVIEW TEXT)");
  }
  Future<Todo> save(Todo todo) async{
    var dbTodo = await db;
    todo.id = await dbTodo.insert(TABLE, todo.toMap());
    return todo;
  }
  Future<List<Todo>> getTodos() async{
    var dbTodo = await db;
    List<Map> maps = await dbTodo.query(TABLE, columns: [ID, NAME, OVERVIEW]);
    List<Todo> todos = [];
    if (maps.length > 0){
      for(int i = 0; i < maps.length; i++){
        todos.add(Todo.fromMap(maps[i]));
      }
    }
    return todos;
  }
  Future<int> update(Todo todo) async{
    var dbTodo = await db;
    return await dbTodo.update(TABLE, todo.toMap(),
    where: '$ID = ?', whereArgs: [todo.id]);
  }
  Future<int> delete(int id) async{
    var dbTodo = await db;
    return await dbTodo.delete(TABLE , where: '$ID = ?', whereArgs: [id]);
  }
  Future close() async{
    var dbTodo = await db;
    dbTodo.close();
  }
}

