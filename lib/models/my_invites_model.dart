class MyInvitesModel {
  final int id;
  final int teamId;
  final int userId;
  final String role;
  final String status;
  final int invitedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final InvitedUser user;
  final InvitedTeam team;

  MyInvitesModel({
    required this.id,
    required this.teamId,
    required this.userId,
    required this.role,
    required this.status,
    required this.invitedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.team,
  });

  factory MyInvitesModel.fromJson(Map<String, dynamic> json) {
    return MyInvitesModel(
      id: json['id'],
      teamId: json['teamId'],
      userId: json['userId'],
      role: json['role'],
      status: json['status'],
      invitedBy: json['invitedBy'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      user: InvitedUser.fromJson(json['user']),
      team: InvitedTeam.fromJson(json['team']),
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
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'user': user.toJson(),
      'team': team.toJson(),
    };
  }
}

class InvitedUser {
  final String firstName;
  final String lastName;

  InvitedUser({
    required this.firstName,
    required this.lastName,
  });

  factory InvitedUser.fromJson(Map<String, dynamic> json) {
    return InvitedUser(
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
    };
  }
}

class InvitedTeam {
  final int id;
  final String name;

  InvitedTeam({
    required this.id,
    required this.name,
  });

  factory InvitedTeam.fromJson(Map<String, dynamic> json) {
    return InvitedTeam(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
