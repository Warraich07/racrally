class TeamModel {
  final String teamCode;
  final int id;
  final String name;
  final String location;
  final String image;
  final int createdBy;
  final String color;
  final String updatedAt;
  final String createdAt;

  TeamModel({
    required this.teamCode,
    required this.id,
    required this.name,
    required this.location,
    required this.image,
    required this.createdBy,
    required this.color,
    required this.updatedAt,
    required this.createdAt,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      teamCode: json['teamCode'],
      id: json['id'],
      name: json['name'],
      location: json['location'],
      image: json['image'],
      createdBy: json['createdBy'],
      color: json['color'],
      updatedAt: json['updatedAt'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'teamCode': teamCode,
      'id': id,
      'name': name,
      'location': location,
      'image': image,
      'createdBy': createdBy,
      'color': color,
      'updatedAt': updatedAt,
      'createdAt': createdAt,
    };
  }
}
