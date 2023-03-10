import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/task.dart';

class TaskTile extends StatelessWidget {
  final Task task;

  const TaskTile({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: _getBGClr(task.color ?? 0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              task.title ?? "",
              style: GoogleFonts.lato(
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.access_time_filled_rounded,
                  color: Colors.grey,
                  size: 18,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  "${task.startTime} - ${task.endTime}",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(fontSize: 13, color: Colors.grey[100]),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(task.note ?? "",
                style:
                    GoogleFonts.lato(textStyle: TextStyle(fontSize: 15, color: Colors.grey[100]))),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 30,
              width: 0.5,
              color: Colors.grey[200]!.withOpacity(0.7),
            ),
            RotatedBox(
              quarterTurns: 0,
              child: Text(
                task.isComplete == 1 ? "Completo" : "Tarefa",
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

_getBGClr(int numberColor) {
  switch (numberColor) {
    case 0:
      return Colors.blue;
    case 1:
      return Colors.red;
    case 2:
      return Colors.yellow;
    default:
      return Colors.blue;
  }
}
