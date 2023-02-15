import 'package:get/state_manager.dart';
import 'package:projeto_ge2/db/db_helper.dart';
import 'package:projeto_ge2/models/task.dart';

class TaskController extends GetxController {
  @override
  Future<void> onReady() async {
    super.onReady();
    await getTasks();
  }

  final taskList = <Task>[].obs;

  Future<int> addTask({Task? task}) async {
    return await DBHelper.insert(task);
  }

  // get all the data from table
  Future<void> getTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
  }

  void delete(Task task) {
    DBHelper.delete(task);
    getTasks();
  }

  void markTaskCompleted(int id) async {
    await DBHelper.update(id);
    getTasks();
  }

  /*Future<void> _initDB() async {
    await DBHelper.initDb();
  }*/
}
