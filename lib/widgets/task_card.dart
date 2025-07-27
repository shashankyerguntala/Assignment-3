import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/models/task_model.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  final int index;

  const TaskCard({required this.task, required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    DateTime dueDate = DateFormat('dd-MM-yy').parse(task.dueDate);
    DateTime today = DateTime.now();
    DateTime todayDateOnly = DateTime(today.year, today.month, today.day);
    int daysLeft = dueDate.difference(todayDateOnly).inDays;

    Color urgencyColor;
    String urgencyText;
    IconData urgencyIcon;

    if (daysLeft == 0) {
      urgencyColor = const Color.fromARGB(255, 255, 43, 28);
      urgencyText = 'Due Today';
      urgencyIcon = Icons.today_rounded;
    } else if (daysLeft == 1) {
      urgencyColor = const Color.fromARGB(255, 255, 157, 0);
      urgencyText = 'Due Tomorrow';
      urgencyIcon = Icons.schedule_rounded;
    } else if (daysLeft <= 3) {
      urgencyColor = Colors.blue;
      urgencyText = 'Due in $daysLeft days';
      urgencyIcon = Icons.calendar_today_rounded;
    } else {
      urgencyColor = Colors.grey;
      urgencyText = 'Due in $daysLeft days';
      urgencyIcon = Icons.calendar_month_rounded;
    }

    return Card(
      elevation: 3,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              ReorderableDragStartListener(
                index: index,
                child: Icon(
                  Icons.drag_handle_rounded,
                  color: Colors.grey.shade600,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (task.title)[0].toUpperCase() + (task.title).substring(1),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: urgencyColor.withAlpha(40),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: urgencyColor),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(urgencyIcon, size: 16, color: urgencyColor),
                        const SizedBox(width: 6),
                        Text(
                          urgencyText,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: urgencyColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
