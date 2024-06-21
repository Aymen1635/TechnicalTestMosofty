import 'package:flutter/material.dart';
import 'package:test_technique/Project/Controller/ProjectService.dart';
import 'package:test_technique/Project/Model/Project.dart';

class ProjectsAffectedListWidget extends StatefulWidget {
  @override
  _ProjectsAffectedListWidgetState createState() =>
      _ProjectsAffectedListWidgetState();
}

class _ProjectsAffectedListWidgetState
    extends State<ProjectsAffectedListWidget> {
  final ProjectService _projectService = ProjectService();
  List<Project> _projects = [];

  @override
  void initState() {
    super.initState();
    _fetchProjectsAffectedToUsers();
  }

  Future<void> _fetchProjectsAffectedToUsers() async {
    try {
      List<Project> projects =
          await _projectService.fetchProjectsAffectedToUsers();
      setState(() {
        _projects = projects;
      });
    } catch (e) {
      print('Error fetching projects affected to users: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Projects Affected to Users'),
      ),
      body: _buildProjectList(),
    );
  }

  Widget _buildProjectList() {
    return ListView.builder(
      itemCount: _projects.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_projects[index].nom),
          subtitle: Text(_projects[index].description),
          onTap: () {
          },
        );
      },
    );
  }
}
