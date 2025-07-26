import 'package:flutter/material.dart';
import 'package:to_do_app/models/task_model.dart';
import 'package:to_do_app/screens/add_edit_task_page.dart';
import 'package:to_do_app/widgets/task_builder.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<TaskModel> taskList = [];

  Future<List<TaskModel>> getTask() async {
    await Future.delayed(Duration(seconds: 1));
    return taskList;
  }

  Stream<int> getTaskCount() async* {
    yield taskList.length;
  }

  Future<void> navigateToAddOrEdit() async {
    final newTask = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            AddEditTaskPage(name: 'New Task ', buttonName: 'Save'),
      ),
    );
    if (newTask != null) {
      setState(() {
        taskList.add(newTask);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: StreamBuilder<int>(
          stream: getTaskCount(),
          builder: (context, snapshot) {
            final count = snapshot.data ?? 0;
            return Text(
              'Tasks ($count)',
              style: TextStyle(fontWeight: FontWeight.bold),
            );
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: navigateToAddOrEdit,
              icon: Icon(Icons.add, size: 30),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TaskBuilder(futureTasks: getTask(), key: ValueKey(taskList.length)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddOrEdit,
        child: Icon(Icons.add),
      ),
    );
  }
}
