import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:projeto_ge2/controllers/task_controller.dart';
import 'package:projeto_ge2/page/theme.dart';
import 'package:projeto_ge2/page/todo_list_form.dart';

import '../models/task.dart';
import '../widgets/task_tile.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final _taskController = Get.put(TaskController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda'),
        backgroundColor: const Color.fromARGB(255, 252, 120, 120),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color.fromARGB(255, 252, 120, 120),
        onPressed: () async {
          await Get.to(() => const TodoListForm());
          _taskController.getTasks();
        },
        label: const Text('Agendar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 8,
            ),
            Text(
              DateFormat.yMMMMd('Pt').format(DateTime.now()),
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Hoje',
              style: subHeadingStyle,
            ),
            DatePicker(
              height: 100,
              width: 80,
              locale: 'PT',
              onDateChange: ((selectedDate) {
                setState(() {
                  selectedDate = selectedDate;
                });
              }),
              DateTime.now(),
              selectedTextColor: Get.isDarkMode ? Colors.white : Colors.black,
              initialSelectedDate: DateTime.now(),
              selectionColor: Colors.redAccent,
              dayTextStyle: TextStyle(
                  fontWeight: FontWeight.bold, color: Get.isDarkMode ? Colors.white : Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            _showTasks(),
          ],
        ),
      ),
    );
  }

  _showTasks() {
    return Expanded(
        child: Obx(
      () => ListView.builder(
        itemCount: _taskController.taskList.length,
        itemBuilder: (context, index) {
          Task task = _taskController.taskList[index];
          return AnimationConfiguration.staggeredList(
            position: index,
            child: SlideAnimation(
              child: FadeInAnimation(
                child: GestureDetector(
                  onTap: () {
                    _showBottomSheet(context, task);
                  },
                  child: TaskTile(task: task),
                ),
              ),
            ),
          );
        },
      ),
    ));
  }
}

_showBottomSheet(BuildContext context, Task task) {
  Get.bottomSheet(
    SafeArea(
      child: Container(
        padding: const EdgeInsets.only(top: 4),
        height: task.isComplete == 1
            ? MediaQuery.of(context).size.height * 0.24
            : MediaQuery.of(context).size.height * 0.32,
        color: Get.isDarkMode ? Colors.grey : Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 6,
              width: 120,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey[300]),
            ),
            const SizedBox(height: 50),
            task.isComplete == 1
                ? Container()
                : _bottonSheetButton(
                    context: context,
                    clr: Colors.blue,
                    label: "Atividade Realizada",
                    onTap: () {
                      var taskController = Get.put(TaskController());
                      taskController.markTaskCompleted(task.id!);

                      Get.back();
                    },
                  ),
            _bottonSheetButton(
              context: context,
              clr: Colors.red,
              label: "Deletar",
              onTap: () {
                var taskController = Get.put(TaskController());
                taskController.delete(task);

                Get.back();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            _bottonSheetButton(
                context: context,
                clr: Colors.white,
                label: "Fechar",
                onTap: () {
                  Get.back();
                },
                isClose: true)
          ],
        ),
      ),
    ),
    backgroundColor: Get.isDarkMode ? Colors.grey : Colors.white,
  );
}

_bottonSheetButton(
    {required String label,
    required Color clr,
    required Function()? onTap,
    bool isClose = false,
    required BuildContext context}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      height: 55,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: isClose == true
              ? Get.isDarkMode
                  ? Colors.grey[600]!
                  : Colors.grey[300]!
              : clr,
        ),
        borderRadius: BorderRadius.circular(20),
        color: isClose == true ? Colors.transparent : clr,
      ),
      child: Center(
        child: Text(
          label,
          style: isClose ? titleStyle : titleStyle.copyWith(color: Colors.white),
        ),
      ),
    ),
  );
}
