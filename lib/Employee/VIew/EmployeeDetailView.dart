import 'package:flutter/material.dart';
import 'package:test_technique/Employee/Controller/EmployeeService.dart';
import 'package:test_technique/Employee/Model/Employee.dart';

class EmployeeDetailView extends StatefulWidget {
  final int? employeeId;

  const EmployeeDetailView({required this.employeeId});

  @override
  _EmployeeDetailViewState createState() => _EmployeeDetailViewState();
}

class _EmployeeDetailViewState extends State<EmployeeDetailView> {
  final EmployeeService _employeeService = EmployeeService();
  late Future<Employee> _futureEmployee;

  @override
  void initState() {
    super.initState();
    _futureEmployee = _employeeService.getEmployeeById(widget.employeeId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Details'),
      ),
      body: FutureBuilder<Employee>(
        future: _futureEmployee,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No employee found'));
          } else {
            Employee employee = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${employee.nom} ${employee.prenom}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text('Username: ${employee.username}'),
                  const SizedBox(height: 4),
                  Text('Email: ${employee.mail}'),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
