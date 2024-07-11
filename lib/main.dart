import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_prac/core/di/dependency_injection.dart';

import 'core/feature/filter_prefs/filter_prefs.dart';
import 'core/feature/home/home_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home:  Home(),
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/FilterPrefs' : (context) => const FilterPrefs(),
      },
    );
  }
}