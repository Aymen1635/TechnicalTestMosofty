class Project {
  int? id;
  String nom;
  String description;
  double latitude;
  double longitude;

  Project({
    this.id,
    required this.nom,
    required this.description,
    required this.latitude,
    required this.longitude,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'] as int?,
      nom: json['nom'] ?? '',
      description: json['description'] ?? '',
      latitude: json['latitude'] != null
          ? double.parse(json['latitude'].toString())
          : 0.0,
      longitude: json['longitude'] != null
          ? double.parse(json['longitude'].toString())
          : 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  @override
  String toString() {
    return 'Project(id: $id, nom: $nom, description: $description, latitude: $latitude, longitude: $longitude)';
  }
}
