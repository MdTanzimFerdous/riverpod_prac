import 'dart:async';

import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class AppDatabase {
  // static final AppDatabase _singleton = AppDatabase._();
  //
  // static AppDatabase get instance => _singleton;
  //
  // Completer<Database>? _dbOpenCompleter;
  //
  // AppDatabase._();
  //
  // Future<Database?> get database async {
  //   if(_dbOpenCompleter == null) {
  //     _dbOpenCompleter = Completer();
  //     _openDatabase();
  //   }
  //   return null;
  // }
  //
  // Future _openDatabase() async {
  //   final appDocumentDir = await getApplicationDocumentsDirectory();
  //   final dbPath = join(appDocumentDir.path, 'demo.db');
  //   final database = await databaseFactoryIo.openDatabase(dbPath);
  //   _dbOpenCompleter?.complete(database);
  // }

  late Database db;

  setupDB()async{
    final appDirectory = await getApplicationDocumentsDirectory();

    db = await databaseFactoryIo
        .openDatabase("${appDirectory.path}/tanzim2.db");
  }
}
