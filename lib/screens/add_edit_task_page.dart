import 'package:flutter/material.dart';
import 'package:to_do_app/models/task_model.dart';

class AddEditTaskPage extends StatefulWidget {
  final TaskModel? existingTask;
  final String name;
  final String buttonName;

  const AddEditTaskPage({
    this.existingTask,
    required this.name,
    required this.buttonName,
    super.key,
  });

  @override
  State<AddEditTaskPage> createState() => _AddEditTaskPageState();
}

class _AddEditTaskPageState extends State<AddEditTaskPage> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController duedateController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(
      text: widget.existingTask?.title ?? '',
    );
    descriptionController = TextEditingController(
      text: widget.existingTask?.description ?? '',
    );
    duedateController = TextEditingController(
      text: widget.existingTask?.dueDate ?? '',
    );
  }

  void addTask() {
    final title = titleController.text;
    final description = descriptionController.text;
    final dueDate = duedateController.text;
    if (title.isNotEmpty) {
      int i = 0;
      i++;
      final newTask = TaskModel(
        id: '$i',
        title: title,
        description: description,
        dueDate: dueDate,
      );
      Navigator.pop(context, newTask);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please Enter Valid Details')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.close),
        ),
        centerTitle: true,
        title: Text(widget.name, style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //! title start
            const SizedBox(height: 5),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 205, 232, 255),
                borderRadius: BorderRadius.circular(10),
              ),

              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: "Title",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            //! description start
            Container(
              height: (MediaQuery.of(context).size.height) / 4,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 205, 232, 255),
                borderRadius: BorderRadius.circular(10),
              ),

              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  maxLines: 6,
                  controller: descriptionController,
                  decoration: InputDecoration(
                    hintText: "Description",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            //! due date start
            const SizedBox(height: 20),

            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 205, 232, 255),
                borderRadius: BorderRadius.circular(10),
              ),

              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  controller: duedateController,
                  decoration: InputDecoration(
                    hintText: "Due Date",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 60),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: addTask,

            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            child: Text(
              widget.buttonName,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
