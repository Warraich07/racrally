class MyEventInvitesModel {
  final int id;
  final int? teamId;
  final int userId;
  final int eventId;
  final String? role;
  final String status;
  final int invitedBy;
  final String createdAt;
  final String updatedAt;
  final SimpleUser user;
  final Event event;

  MyEventInvitesModel({
    required this.id,
    this.teamId,
    required this.userId,
    required this.eventId,
    this.role,
    required this.status,
    required this.invitedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.event,
  });

  factory MyEventInvitesModel.fromJson(Map<String, dynamic> json) {
    return MyEventInvitesModel(
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
      event: Event.fromJson(json['event']),
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

class Event {
  final int id;
  final String name;

  Event({required this.id, required this.name});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      name: json['name'],
    );
  }
}
