import 'package:flutter/material.dart';
import 'package:test_technique/Employee/VIew/EmployeeListView.dart';
import 'package:test_technique/Employee/VIew/EmployeeListview2.dart';
import 'package:test_technique/Project/Controller/ProjectService.dart';
import 'package:test_technique/Project/Model/Project.dart';

class ProjectsListWidget extends StatefulWidget {
  @override
  _ProjectsListWidgetState createState() => _ProjectsListWidgetState();
}

class _ProjectsListWidgetState extends State<ProjectsListWidget> {
  final ProjectService _projectService = ProjectService();
  List<Project> _projects = [];

  @override
  void initState() {
    super.initState();
    _fetchProjects();
  }

  Future<void> _fetchProjects() async {
    try {
      List<Project> projects = await _projectService.fetchProjects();
      setState(() {
        _projects = projects;
      });
    } catch (e) {
      print('Error fetching projects: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Projects'),
      ),
      body: _buildProjectList(),
    );
  }

  Widget _buildProjectList() {
    return ListView.builder(
      itemCount: _projects.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(_projects[index].nom),
            subtitle: Text(_projects[index].description),
            trailing: ElevatedButton(
              child: Text('Affect'),
              onPressed: () {
                _navigateToEmployeeListView(_projects[index]);
              },
            ),
            onTap: () {
            },
          ),
        );
      },
    );
  }

  void _navigateToEmployeeListView(Project project) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EmployeeListView2(project: project),
      ),
    );
  }
}
