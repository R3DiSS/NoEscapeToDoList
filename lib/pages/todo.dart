import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodoTask {
  String taskName;
  String taskType;
  DateTime taskDueDate;
  TimeOfDay taskDueTime;
  bool isDone;

  TodoTask({
    required this.taskName,
    required this.taskType,
    required this.taskDueDate,
    required this.taskDueTime,
    this.isDone = false,
  });
}

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  List<TodoTask> tasks = [];
  final taskController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String taskType = 'Study';

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Scaffold(
          appBar: AppBar(
            title: Text('To-Do List'),
            backgroundColor: Colors.yellow,
          ),
          body: Stack(
            children: <Widget>[
              tasks.isEmpty
                  ? Center(
                child: Text("No tasks yet"),
              )
                  : ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(tasks[index].taskName),
                    onDismissed: (direction) {
                      setState(() {
                        tasks.removeAt(index);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Task dismissed")),
                      );
                    },
                    child: Card(
                      child: ListTile(
                        leading: Checkbox(
                          value: tasks[index].isDone,
                          onChanged: (bool? value) {
                            setState(() {
                              tasks[index].isDone = value!;
                            });
                          },
                        ),
                        title: Text(
                          tasks[index].taskName,
                          style: tasks[index].isDone
                              ? TextStyle(
                            decoration:
                            TextDecoration.lineThrough,
                            color: Colors.green,
                          )
                              : null,
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            getIcon(tasks[index].taskType),
                            Text(DateFormat('MM/dd/yyyy').format(
                                tasks[index].taskDueDate) +
                                ' ' +
                                tasks[index].taskDueTime.format(context))
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                bottom: 10.0,
                left: constraints.maxWidth / 2 - 28,
                child: FloatingActionButton(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        contentPadding: EdgeInsets.all(20.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            TextField(
                              controller: taskController,
                              decoration: InputDecoration(hintText: "Enter task"),
                            ),
                            SizedBox(height: 10.0), // Add some spacing
                            ElevatedButton(
                              onPressed: () => _selectDate(context),
                              child: Text('Select deadline date'),
                            ),
                            SizedBox(height: 10.0), // Add some spacing
                            ElevatedButton(
                              onPressed: () => _selectTime(context),
                              child: Text('Select deadline time'),
                            ),
                            SizedBox(height: 10.0), // Add some spacing
                            DropdownButton<String>(
                              value: taskType,
                              items: <String>[
                                'Study',
                                'Work',
                                'Sport',
                                'Other'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  taskType = newValue!;
                                });
                              },
                            ),
                          ],
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              setState(() {
                                tasks.add(TodoTask(
                                    taskName: taskController.text,
                                    taskType: taskType,
                                    taskDueDate: selectedDate,
                                    taskDueTime: selectedTime));
                                taskController.clear();
                              });
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  ),
                  child: Icon(Icons.add),
                  backgroundColor: Colors.yellow,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Icon getIcon(String taskType) {
    switch (taskType) {
      case 'Study':
        return Icon(Icons.edit);
      case 'Work':
        return Icon(Icons.work);
      case 'Sport':
        return Icon(Icons.fitness_center);
      case 'Other':
        return Icon(Icons.star);
      default:
        return Icon(Icons.help_outline);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime)
      setState(() {
        selectedTime = picked;
      });
  }
}




