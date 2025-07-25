import 'package:flutter/material.dart';
import 'package:to_do_app/models/task_model.dart';
import 'package:to_do_app/screens/add_edit_task_page.dart';
import 'package:to_do_app/widgets/task_card.dart';

class TaskBuilder extends StatefulWidget {
  final Future<List<TaskModel>> futureTasks;
  const TaskBuilder({required this.futureTasks, super.key});

  @override
  State<TaskBuilder> createState() => _TaskBuilderState();
}

class _TaskBuilderState extends State<TaskBuilder> {
  List<TaskModel> taskListDummy = [];
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getTasks();
  }

  void getTasks() async {
    final tasks = await widget.futureTasks;
    setState(() {
      taskListDummy = tasks;
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoaded) {
      return const Center(child: CircularProgressIndicator());
    }

    if (taskListDummy.isEmpty) {
      return const Center(child: Text('No tasks yet'));
    }

    return Expanded(
      child: ReorderableListView.builder(
        itemCount: taskListDummy.length,
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (newIndex > oldIndex) {
              newIndex -= 1;
            }
            final task = taskListDummy.removeAt(oldIndex);
            taskListDummy.insert(newIndex, task);
          });
        },
        itemBuilder: (context, index) {
          final task = taskListDummy[index];
          return Container(
            key: ValueKey(index),
            padding: const EdgeInsets.all(3.0),
            child: GestureDetector(
              onTap: () async {
                final updatedTask = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddEditTaskPage(
                      existingTask: task,
                      name: 'Edit Task',
                      buttonName: 'Update',
                    ),
                  ),
                );
                if (updatedTask != null) {
                  setState(() {
                    taskListDummy[index] = updatedTask;
                  });
                }
              },
              child: TaskCard(task: task, index: index),
            ),
          );
        },
      ),
    );
  }
}
