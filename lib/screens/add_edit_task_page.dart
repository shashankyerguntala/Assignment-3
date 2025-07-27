import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  DateTime? selectedDate;

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
      final newTask = TaskModel(
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

  void datePicker() async {
    DateTime now = DateTime.now();
    DateTime firstDate = DateTime(now.year, now.month, now.day);
    DateTime lastDate = DateTime(now.year + 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (pickedDate != null) {
      String formattedDate = DateFormat('dd-MM-yy').format(pickedDate);
      duedateController.text = formattedDate;
    } else {
      duedateController.text = 'No date ';
    }
    setState(() {
      selectedDate = pickedDate;
    });
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

            
            const SizedBox(height: 20),

            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 205, 232, 255),
                borderRadius: BorderRadius.circular(10),
              ),

              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: duedateController,
                        decoration: InputDecoration(
                          hintText: "Due Date",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: datePicker,
                      icon: Icon(Icons.calendar_month),
                    ),
                  ],
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
