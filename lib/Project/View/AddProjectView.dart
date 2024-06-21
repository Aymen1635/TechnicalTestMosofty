import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart' as latlong;
import 'package:permission_handler/permission_handler.dart'; // Import permission_handler

import 'package:test_technique/Project/Controller/ProjectService.dart';
import 'package:test_technique/Project/Model/Project.dart';

class AddProjectView extends StatefulWidget {
  @override
  _AddProjectViewState createState() => _AddProjectViewState();
}

class _AddProjectViewState extends State<AddProjectView> {
  final TextEditingController nomController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();

  latlong.LatLng? selectedLocation;

  final ProjectService _projectService = ProjectService();

  Future<void> _addProject() async {
    String nom = nomController.text.trim();
    String description = descriptionController.text.trim();
    double latitude = double.parse(latitudeController.text.trim());
    double longitude = double.parse(longitudeController.text.trim());

    final Project newProject = Project(
      nom: nom,
      description: description,
      latitude: latitude,
      longitude: longitude,
    );

    try {
      await _projectService.addProject(newProject);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Project added successfully'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add project: $e'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _requestLocationPermission(); 
  }

  Future<void> _requestLocationPermission() async {
    PermissionStatus permission = await Permission.location.request();
    if (permission == PermissionStatus.granted) {
     
      _getCurrentLocation();
    } else {
      print('Location permission denied');
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        selectedLocation =
            latlong.LatLng(position.latitude, position.longitude);
        latitudeController.text = position.latitude.toString();
        longitudeController.text = position.longitude.toString();
      });
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  void _onMapTap(latlong.LatLng tapped) {
    setState(() {
      selectedLocation = tapped;
      latitudeController.text = tapped.latitude.toString();
      longitudeController.text = tapped.longitude.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Project'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: nomController,
              decoration: InputDecoration(labelText: 'Nom'),
            ),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextFormField(
              controller: latitudeController,
              decoration: InputDecoration(labelText: 'Latitude'),
              enabled: false,
            ),
            TextFormField(
              controller: longitudeController,
              decoration: InputDecoration(labelText: 'Longitude'),
              enabled: false,
            ),
            Expanded(
              child: FlutterMap(
                options: MapOptions(
                  center: selectedLocation ?? latlong.LatLng(0.0, 0.0),
                  zoom: 15,
                  onTap: (tapPosition, point) {
                    _onMapTap(point);
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                  ),
                  if (selectedLocation != null)
                    MarkerLayer(
                      markers: [
                        Marker(
                          width: 80.0,
                          height: 80.0,
                          point: selectedLocation!,
                          builder: (ctx) => Container(
                            child: Icon(
                              Icons.location_pin,
                              size: 50,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _addProject,
              child: Text('Add Project'),
            ),
          ],
        ),
      ),
    );
  }
}
