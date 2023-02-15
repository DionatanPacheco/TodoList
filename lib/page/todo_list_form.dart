import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:projeto_ge2/controllers/task_controller.dart';
import 'package:projeto_ge2/models/task.dart';
import 'package:projeto_ge2/page/theme.dart';
import 'package:projeto_ge2/widgets/appbar.dart';
import 'package:projeto_ge2/widgets/input_form.dart';

class TodoListForm extends StatefulWidget {
  const TodoListForm({super.key});

  @override
  State<TodoListForm> createState() => _TodoListFormState();
}

class _TodoListFormState extends State<TodoListForm> {
  DateTime _selectedDate = DateTime.now();
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  late String _endTime = "09:30 AM";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String _selectedRepeat = "Nenhuma";
  List<String> repeatList = ["Nenhuma", "Diario", "Semanal", "Mensal"];
  int _selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarForm(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              'Add. Tarefas...',
              style: subHeadingStyle,
            ),
            InputForm(
              title: 'Titulo',
              hint: 'Nome Completo',
              controller: _titleController,
            ),
            InputForm(
              title: 'Nota',
              hint: 'Observação',
              controller: _noteController,
            ),
            InputForm(
              title: 'Data',
              hint: DateFormat.yMEd().format(_selectedDate),
              widget: IconButton(
                  onPressed: () {
                    getDateFromUser();
                  },
                  icon: const Icon(Icons.calendar_month)),
            ),
            Row(
              children: [
                Expanded(
                  child: InputForm(
                    title: "Hora inicial",
                    hint: _startTime,
                    widget: IconButton(
                      onPressed: () {
                        getTimeFromUser(isStartTime: true);
                      },
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: InputForm(
                    title: "Hora final",
                    hint: _endTime,
                    widget: IconButton(
                      onPressed: () {
                        getTimeFromUser(isStartTime: false);
                      },
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ),
                ),
              ],
            ),
            InputForm(
              title: 'Lembretes',
              hint: '$_selectedRemind minutos restantes.',
              widget: DropdownButton(
                underline: Container(
                  height: 0,
                ),
                onChanged: (String? newvalue) {
                  setState(() {
                    _selectedRemind = int.parse(newvalue!);
                  });
                },
                items: remindList.map<DropdownMenuItem<String>>((int value) {
                  return DropdownMenuItem<String>(
                    value: value.toString(),
                    child: Text(value.toString()),
                  );
                }).toList(),
                icon: const Icon(Icons.keyboard_arrow_down),
                iconSize: 32,
                elevation: 4,
                style: subtitleStyle,
              ),
            ),
            InputForm(
              title: 'Repetir',
              hint: '$_selectedRepeat.',
              widget: DropdownButton(
                underline: Container(
                  height: 0,
                ),
                onChanged: (String? newvalue) {
                  setState(() {
                    _selectedRepeat = newvalue!;
                  });
                },
                items: repeatList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                icon: const Icon(Icons.keyboard_arrow_down),
                iconSize: 32,
                elevation: 4,
                style: subtitleStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _colorPallette(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(20),
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                    onPressed: () => _validateDate(),
                    child: const Text('Add na Agenda'),
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }

  _validateDate() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      //add data base
      _addTasktoDb();
      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar('Requer', 'Todos os campos são necessarios!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          icon: const Icon(Icons.warning));
    }
  }

  _addTasktoDb() async {
    int value = await _taskController.addTask(
        task: Task(
            note: _noteController.text,
            title: _titleController.text,
            date: DateFormat.yMd().format(_selectedDate),
            startTime: _startTime,
            endTime: _endTime,
            remind: _selectedRemind,
            repeat: _selectedRepeat,
            color: _selectedColor,
            isComplete: 0));
    debugPrint("My id is " "$value");
  }

  getDateFromUser() async {
    DateTime? pikerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2025));

    if (pikerDate != null) {
      setState(() {
        _selectedDate = pikerDate;
      });
    } else {}
  }

  getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();

    //String formatedTime = pickedTime.format(context);
    if (pickedTime == null) {
    } else if (isStartTime == true) {
      setState(() {
        _startTime = pickedTime.format(context);
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = pickedTime.format(context);
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
            // _startTime => 10:30 AM
            hour: int.parse(_startTime.split(":")[0]),
            minute: int.parse(_startTime.split(":")[1].split(" ")[0])));
  }

  _colorPallette() {
    return Column(
      children: [
        Text(
          'Color',
          style: titleStyle,
        ),
        Wrap(
          children: List<Widget>.generate(3, (int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: CircleAvatar(
                    radius: 14,
                    backgroundColor: index == 0
                        ? Colors.blue
                        : index == 1
                            ? Colors.red
                            : Colors.yellow,
                    child: _selectedColor == index
                        ? const Icon(
                            Icons.done,
                            color: Colors.white,
                            size: 16,
                          )
                        : Container()),
              ),
            );
          }),
        )
      ],
    );
  }
}
