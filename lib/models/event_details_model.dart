class EventDetailsModel {
  final int id;
  final String name;
  final int createdBy;
  final String inviteAttandee;
  final String location;
  final DateTime date;
  final bool rsvp;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<InviteModel> invites;

  EventDetailsModel({
    required this.id,
    required this.name,
    required this.createdBy,
    required this.inviteAttandee,
    required this.location,
    required this.date,
    required this.rsvp,
    required this.createdAt,
    required this.updatedAt,
    required this.invites,
  });

  factory EventDetailsModel.fromJson(Map<String, dynamic> json) {
    return EventDetailsModel(
      id: json['id'],
      name: json['name'],
      createdBy: json['createdBy'],
      inviteAttandee: json['inviteAttandee'],
      location: json['location'],
      date: DateTime.parse(json['date']),
      rsvp: json['rsvp'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      invites: (json['invites'] as List?)
          ?.map((x) => InviteModel.fromJson(x))
          .toList() ??
          [],
    );
  }
}

class InviteModel {
  final int id;
  final int? teamId;
  final int userId;
  final int eventId;
  final String? role;
  final String status;
  final int invitedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UserModel user;

  InviteModel({
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
  });

  factory InviteModel.fromJson(Map<String, dynamic> json) {
    return InviteModel(
      id: json['id'],
      teamId: json['teamId'],
      userId: json['userId'],
      eventId: json['eventId'],
      role: json['role'],
      status: json['status'],
      invitedBy: json['invitedBy'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      user: UserModel.fromJson(json['user']),
    );
  }
}

class UserModel {
  final int id;
  final String firstName;
  final String lastName;
  final String email;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
    );
  }
}
