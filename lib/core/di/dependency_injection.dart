import 'package:get_it/get_it.dart';
import 'package:riverpod_prac/core/database/app_database.dart';

final sl = GetIt.I;

setupServiceLocator() async {
  final appDatabase = AppDatabase();
  await appDatabase.setupDB();
  sl.registerLazySingleton<AppDatabase>(() => appDatabase);
}