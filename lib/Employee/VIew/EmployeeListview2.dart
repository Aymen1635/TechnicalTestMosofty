import 'package:flutter/material.dart';
import 'package:test_technique/Employee/Controller/EmployeeService.dart';
import 'package:test_technique/Employee/Model/Employee.dart';
import 'package:test_technique/Project/Controller/ProjectService.dart';
import 'package:test_technique/Project/Model/Project.dart';

class EmployeeListView2 extends StatefulWidget {
  final Project? project;

  EmployeeListView2({this.project});

  @override
  _EmployeeListView2State createState() => _EmployeeListView2State();
}

class _EmployeeListView2State extends State<EmployeeListView2> {
  final EmployeeService _employeeService = EmployeeService();
  final ProjectService _projectService = ProjectService();
  late Future<List<Employee>> _futureEmployees;

  @override
  void initState() {
    super.initState();
    _loadEmployees();
  }

  Future<void> _loadEmployees() async {
    try {
      _futureEmployees = _employeeService.fetchEmployees();
    } catch (e) {
      print('Error loading employees: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Employee'),
      ),
      body: FutureBuilder<List<Employee>>(
        future: _futureEmployees,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print('Error: ${snapshot.error}');
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            print('No employees found');
            return Center(child: Text('No employees found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Employee employee = snapshot.data![index];
                return ListTile(
                  title: Text('${employee.nom} ${employee.prenom}'),
                  subtitle: Text(
                      'Username: ${employee.username}, Mail: ${employee.mail}'),
                  onTap: () {
                    _affectProjectToEmployee(employee);
                    Navigator.pop(context);
                  },
                );
              },
            );
          }
        },
      ),
    );
  }

  void _affectProjectToEmployee(Employee employee) {
    if (widget.project == null) {
      print('Error: Project is null');
      return;
    }

    if (employee.id == null) {
      print('Error: Employee ID is null');
      return;
    }

    try {
      List<UserItem> users = [
        UserItem(
          id: employee.id!,
          itemName: '${employee.nom} ${employee.prenom}',
        ),
      ];

      _projectService
          .affectProjectToUsers(widget.project!.id!, users)
          .then((_) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Success'),
            content: Text('Project affected to employee ${employee.nom}'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }).catchError((error) {
        // Show error dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Failed to affect project to employee'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      });
    } catch (e) {
      print('Error affecting project to employee: $e');
    }
  }
}
