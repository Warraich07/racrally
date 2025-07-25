class MyInvitesModel {
  final int id;
  final int teamId;
  final int userId;
  final String role;
  final String status;
  final int invitedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final InviteUser user;

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
      user: InviteUser.fromJson(json['user']),
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
    };
  }
}

class InviteUser {
  final String firstName;
  final String lastName;

  InviteUser({
    required this.firstName,
    required this.lastName,
  });

  factory InviteUser.fromJson(Map<String, dynamic> json) {
    return InviteUser(
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
