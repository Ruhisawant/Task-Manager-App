import 'package:flutter/material.dart';

void main() {
  runApp(const TaskManagerApp());
}

// Main Application Widget
class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const TaskListScreen(title: 'Task Manager App'),
    );
  }
}

// Task List Screen Widget
class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key, required this.title});
  final String title;

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final List<Map<String, dynamic>> tasks = [];
  final TextEditingController taskController = TextEditingController();
  String selectedPriority = 'Medium';

  // Function to add a new task
  void addTask() {
    if (taskController.text.trim().isNotEmpty) {
      setState(() {
        tasks.add({
          'title': taskController.text.trim(),
          'isChecked': false,
          'priority': selectedPriority,
        });
        taskController.clear();
        selectedPriority = 'Medium';
        sortTasks();
      });
    }
  }

  // Function to toggle task completion status
  void toggleTask(int index, bool? newValue) {
    setState(() {
      tasks[index]['isChecked'] = newValue!;
    });
  }

  // Function to delete a task
  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  // Function to sort tasks by priority
  void sortTasks() {
    setState(() {
      tasks.sort((a, b) {
        const priorityOrder = {'High': 3, 'Medium': 2, 'Low': 1};
        return priorityOrder[b['priority']]!.compareTo(priorityOrder[a['priority']]!);
      });
    });
  }

  // Function to get background color based on priority
  Color getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return Colors.red.shade300;
      case 'Medium':
        return Colors.yellow.shade300;
      case 'Low':
        return Colors.green.shade300;
      default:
        return Colors.grey.shade200;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Input Section for Adding Tasks
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 250,
                    child: TextField(
                      controller: taskController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter task',
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  DropdownButton<String>(
                    value: selectedPriority,
                    items: ['Low', 'Medium', 'High'].map((priority) {
                      return DropdownMenuItem<String>(
                        value: priority,
                        child: Text(priority),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedPriority = value!;
                      });
                    },
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: addTask,
                    child: const Text('Add Task'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            
            // Task List Section
            SizedBox(
              width: 400,
              height: 300,
              child: tasks.isEmpty
                  ? const Center(
                      child: Text(
                        "No tasks added yet.",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: getPriorityColor(tasks[index]['priority']),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child: ListTile(
                            leading: Checkbox(
                              value: tasks[index]['isChecked'],
                              onChanged: (bool? newValue) => toggleTask(index, newValue),
                            ),
                            title: Text(
                              "${tasks[index]['title']} (${tasks[index]['priority']})",
                              style: TextStyle(
                                decoration: tasks[index]['isChecked']
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => deleteTask(index),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}