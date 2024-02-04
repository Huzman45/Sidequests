import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sidequests/backend/table.dart';
import 'package:sidequests/controller/home_controller.dart';
import 'package:sidequests/theme.dart';
import 'package:sidequests/view/home_view.dart';
import 'package:sqflite/sqflite.dart';

const String dbName = "task_store.db";
late final Database db;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  initializeApp();
}

void initializeApp() async {
  final databasesPath = await getDatabasesPath();
  final path = join(databasesPath, dbName);

  try {
    await Directory(databasesPath).create();
  } catch (_) {}

  db = await openDatabase(
    path,
    version: 2,
    onCreate: (Database database, int version) async {
      await database.execute('''
create table ${Tables.taskTable} ( 
  id text primary key, 
  date text not null,
  description text not null,
  completed int not null)
''');
    },
    onUpgrade: (db, oldVersion, newVersion) async =>
        await db.execute('''alter table ${Tables.taskTable}
    add difficulty text not null;'''),
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/home',
      theme: lightMode,
      getPages: [
        GetPage(
          name: '/home',
          page: () => const HomeView(),
          binding: BindingsBuilder.put(() => HomeController()),
        ),
      ],
    );
  }
}
