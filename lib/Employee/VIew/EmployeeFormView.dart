import 'package:flutter/material.dart';
import 'package:test_technique/Employee/Controller/EmployeeService.dart';
import 'package:test_technique/Employee/Model/Employee.dart';

class EmployeeFormView extends StatefulWidget {
  @override
  _EmployeeFormViewState createState() => _EmployeeFormViewState();
}

class _EmployeeFormViewState extends State<EmployeeFormView> {
  final TextEditingController nomController = TextEditingController();
  final TextEditingController prenomController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController mailController = TextEditingController();

  final EmployeeService employeeService = EmployeeService();

  void addEmployee() async {
    String nom = nomController.text.trim();
    String prenom = prenomController.text.trim();
    String username = usernameController.text.trim();
    String mail = mailController.text.trim();

    if (nom.isNotEmpty &&
        prenom.isNotEmpty &&
        username.isNotEmpty &&
        mail.isNotEmpty) {
      Employee newEmployee = Employee(
        nom: nom,
        prenom: prenom,
        username: username,
        mail: mail,
      );

      try {
        await employeeService.addEmployee(newEmployee);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Employee added successfully'),
            duration: Duration(seconds: 2),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to add employee'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Employee'),
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
              onPressed: addEmployee,
              child: const Text('Add Employee'),
            ),
          ],
        ),
      ),
    );
  }
}
