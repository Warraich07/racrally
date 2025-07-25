class SentInvitesModel {
  final Team team;
  final List<Player> activeRoster;
  final List<Player> reservedPlayers;

  SentInvitesModel({
    required this.team,
    required this.activeRoster,
    required this.reservedPlayers,
  });

  factory SentInvitesModel.fromJson(Map<String, dynamic> json) {
    return SentInvitesModel(
      team: Team.fromJson(json['team']),
      activeRoster: List<Player>.from(
        json['active_roster'].map((x) => Player.fromJson(x)),
      ),
      reservedPlayers: List<Player>.from(
        json['reserved_players'].map((x) => Player.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'team': team.toJson(),
      'active_roster': activeRoster.map((x) => x.toJson()).toList(),
      'reserved_players': reservedPlayers.map((x) => x.toJson()).toList(),
    };
  }
}

class Team {
  final int id;
  final String name;
  final String location;
  final String image;
  final String color;
  final String teamCode;
  final int createdBy;

  Team({
    required this.id,
    required this.name,
    required this.location,
    required this.image,
    required this.color,
    required this.teamCode,
    required this.createdBy,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      image: json['image'],
      color: json['color'],
      teamCode: json['teamCode'],
      createdBy: json['createdBy'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'image': image,
      'color': color,
      'teamCode': teamCode,
      'createdBy': createdBy,
    };
  }
}

class Player {
  final int id;
  final int teamId;
  final int userId;
  final String role;
  final String status;
  final int invitedBy;
  final User user;

  Player({
    required this.id,
    required this.teamId,
    required this.userId,
    required this.role,
    required this.status,
    required this.invitedBy,
    required this.user,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'],
      teamId: json['teamId'],
      userId: json['userId'],
      role: json['role'],
      status: json['status'],
      invitedBy: json['invitedBy'],
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'teamId': teamId,
      'userId': userId,
      'role': role,
      'status': status,
      'invitedBy': invitedBy,
      'user': user.toJson(),
    };
  }
}

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
    };
  }
}
