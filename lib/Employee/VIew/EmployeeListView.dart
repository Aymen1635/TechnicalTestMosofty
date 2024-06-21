import 'package:flutter/material.dart';
import 'package:test_technique/Employee/Controller/EmployeeService.dart';
import 'package:test_technique/Employee/Model/Employee.dart';
import 'package:test_technique/Employee/VIew/EmployeeDetailView.dart';
import 'package:test_technique/Employee/VIew/EmployeeEditView.dart';

class EmployeeListView extends StatefulWidget {
  @override
  _EmployeeListViewState createState() => _EmployeeListViewState();
}

class _EmployeeListViewState extends State<EmployeeListView> {
  final EmployeeService _employeeService = EmployeeService();
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
      // Handle error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Employees'),
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
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          icon: Icon(Icons.visibility),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EmployeeDetailView(
                                      employeeId: employee.id)),
                            );
                          }),
                      IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditEmployeeView(
                                        employee: employee,
                                      )),
                            );
                          }),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
