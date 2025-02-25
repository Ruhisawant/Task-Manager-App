import 'package:flutter/material.dart';

void main() {
  runApp(const TaskManagerApp());
}

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Task Manager App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isChecked1 = false;
  bool isChecked2 = false;

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  width: 250,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter text',
                    ),
                  ),
                ),

                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    const Text('Button clicked');
                  },
                  child: const Text('Click me'),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            Container(
              width: 400,
              alignment: Alignment.centerLeft,
              child: ListView(
                shrinkWrap: true,
                children: [
                  CheckboxListTile(
                    title: const Text('Task 1'),
                    subtitle: const Text('Description of task 1'),
                    value: isChecked1,
                    onChanged: (bool? newValue) {
                      setState(() {
                        isChecked1 = newValue!;
                      });
                    },
                    
                  ),
                  CheckboxListTile(
                    title: const Text('Task 2'),
                    subtitle: const Text('Description of task 2'),
                    value: isChecked2,
                    onChanged: (bool? newValue) {
                      setState(() {
                        isChecked2 = newValue!;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
