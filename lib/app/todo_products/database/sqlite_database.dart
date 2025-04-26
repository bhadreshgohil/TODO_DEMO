import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../data/response/todo_products_model.dart';

class SqLiteDatabase extends ICrudUseCases{


  Future<Database> openSQLiteDatabase()async{
    final database = await openDatabase(join(await getDatabasesPath(), 'todo_database.db'),
        onCreate: (db, version) {
          return db.execute(
            'CREATE TABLE todo(id INTEGER PRIMARY KEY, title TEXT, description TEXT,price INTEGER)',
          );
        },
        version: 1
    );
    return database;
  }

  @override
  Future<dynamic> getUserDetail() async{
    final database = await openSQLiteDatabase();
    final response = await database.query('todo');
    return response;
  }



  @override
  Future<dynamic> createData({required GetProductModel dataModel}) async{
    final database = await openSQLiteDatabase();
    final response = await database.insert("todo",dataModel.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
    return {
      "status":response
    };
  }



}

abstract class ICrudUseCases {
  Future<dynamic> createData({required GetProductModel dataModel});
  Future<dynamic> getUserDetail();
}