import 'package:flutter/material.dart';
import 'package:test_technique/Employee/Controller/EmployeeService.dart';
import 'package:test_technique/Employee/Model/Employee.dart';

class EditEmployeeView extends StatefulWidget {
  final Employee employee;

  EditEmployeeView({required this.employee});

  @override
  _EditEmployeeViewState createState() => _EditEmployeeViewState();
}

class _EditEmployeeViewState extends State<EditEmployeeView> {
  final TextEditingController nomController = TextEditingController();
  final TextEditingController prenomController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController mailController = TextEditingController();

  late EmployeeService _employeeService;

  @override
  void initState() {
    super.initState();
    _employeeService = EmployeeService();


    nomController.text = widget.employee.nom;
    prenomController.text = widget.employee.prenom;
    usernameController.text = widget.employee.username;
    mailController.text = widget.employee.mail;
  }

  void editEmployee() async {
    String nom = nomController.text.trim();
    String prenom = prenomController.text.trim();
    String username = usernameController.text.trim();
    String mail = mailController.text.trim();

    Employee updatedEmployee = Employee(
      id: widget.employee.id,
      nom: nom,
      prenom: prenom,
      username: username,
      mail: mail,
    );

    try {
      await _employeeService.updateEmployee(updatedEmployee);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Employee updated successfully'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to update employee'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Employee'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: nomController,
              decoration: const InputDecoration(labelText: 'Nom'),
            ),
            TextFormField(
              controller: prenomController,
              decoration: const InputDecoration(labelText: 'Prenom'),
            ),
            TextFormField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextFormField(
              controller: mailController,
              decoration: const InputDecoration(labelText: 'Mail'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: editEmployee,
              child: const Text('Edit Employee'),
            ),
          ],
        ),
      ),
    );
  }
}
