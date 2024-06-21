class Employee {
  int? id;
  String nom;
  String prenom;
  String username;
  String mail;

  Employee({
    this.id,
    required this.nom,
    required this.prenom,
    required this.username,
    required this.mail,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json['idperson'] as int?,
        nom: json['nom'] ?? '',
        prenom: json['prenom'] ?? '',
        username: json['username'] ?? '',
        mail: json['mail'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'nom': nom,
        'prenom': prenom,
        'username': username,
        'mail': mail,
      };

  @override
  String toString() {
    return 'Employee(id: $id, nom: $nom, prenom: $prenom, username: $username, mail: $mail)';
  }
}
