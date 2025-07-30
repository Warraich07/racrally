class MyTeamInvitesModel {
  final int id;
  final int teamId;
  final int userId;
  final int? eventId;
  final String role;
  final String status;
  final int invitedBy;
  final String createdAt;
  final String updatedAt;
  final SimpleUser user;
  final Team team;

  MyTeamInvitesModel({
    required this.id,
    required this.teamId,
    required this.userId,
    this.eventId,
    required this.role,
    required this.status,
    required this.invitedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.team,
  });

  factory MyTeamInvitesModel.fromJson(Map<String, dynamic> json) {
    return MyTeamInvitesModel(
      id: json['id'],
      teamId: json['teamId'],
      userId: json['userId'],
      eventId: json['eventId'],
      role: json['role'],
      status: json['status'],
      invitedBy: json['invitedBy'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      user: SimpleUser.fromJson(json['user']),
      team: Team.fromJson(json['team']),
    );
  }
}

class SimpleUser {
  final String firstName;
  final String lastName;

  SimpleUser({required this.firstName, required this.lastName});

  factory SimpleUser.fromJson(Map<String, dynamic> json) {
    return SimpleUser(
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }
}

class Team {
  final int id;
  final String name;

  Team({required this.id, required this.name});

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'],
      name: json['name'],
    );
  }
}
