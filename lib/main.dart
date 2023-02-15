// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:projeto_ge2/page/home_page.dart';
import 'package:projeto_ge2/page/theme.dart';
import 'package:projeto_ge2/page/todo_list.dart';
import 'package:projeto_ge2/page/todo_list_form.dart';
import 'package:projeto_ge2/services/theme_services.dart';

import 'db/db_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDb();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const HOME = '/';
  static const TODO = 'todo_list';
  static const TODOFORM = 'todo_list_form';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeServices().theme,
      routes: {
        HOME: ((context) => const HomePage()),
        TODOFORM: (context) => const TodoListForm(),
        TODO: (context) => const TodoList()
      },
    );
  }
}
