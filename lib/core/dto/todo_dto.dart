import 'package:riverpod_prac/core/database/app_database.dart';
import 'package:riverpod_prac/core/di/dependency_injection.dart';
import 'package:riverpod_prac/core/models/todo_model.dart';
import 'package:sembast/sembast.dart';

class TodoDto{
  static const String todoDb = "todo_db";
  final todoStore = stringMapStoreFactory.store(todoDb);
  AppDatabase appDatabase = sl.get<AppDatabase>();

  putTodo({required Todo todo})async{
    try{

      await todoStore.record(todo.id).put(appDatabase.db, todo.toJson());

    }catch(e){
      print("Database insertion failed");
    }
  }

  deleteTodo({required Todo todo}) async {
    try {
      await todoStore.record(todo.id).delete(appDatabase.db);
    } catch (e) {
      print("Database deletion failed");
    }
  }

  // updateTodo({required Todo todo}) async {
  //   try {
  //     await todoStore.record(todo.id).update(appDatabase.db, todo.toJson());
  //   } catch (e) {
  //     print("ignore");
  //   }
  // }

  Future<List<Todo>> getTodos()async{
    try{

      var result = await todoStore.find(appDatabase.db);

      return result.map((e) => Todo.fromJson(e.value)).toList();

    }catch(e){
      print("Database insertion failed");
    }
    return [];
  }

}