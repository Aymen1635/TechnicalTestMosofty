import 'package:flutter/material.dart';
import 'package:test_technique/Employee/VIew/EmployeeFormView.dart';
import 'package:test_technique/Employee/VIew/EmployeeListView.dart';
import 'package:test_technique/Project/View/AddProjectView.dart';
import 'package:test_technique/Project/View/ProjectsAffectedView.dart';
import 'package:test_technique/Project/View/ProjectsListView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmployeeFormView()),
                );
              },
              child: const Text('Go to Add Employee'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmployeeListView()),
                );
              },
              child: const Text('Go to Employee List'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddProjectView()),
                );
              },
              child: const Text('Go to Add Project'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProjectsListWidget()),
                );
              },
              child: const Text('Go to Projects List'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProjectsAffectedListWidget()),
                );
              },
              child: const Text('Go to Projects Affected List'),
            )
          ],
        ),
      ),
    );
  }
}
