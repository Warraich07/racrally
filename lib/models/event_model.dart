class EventModel {
  final int id;
  final String name;
  final int createdBy;
  final String inviteAttandee;
  final String location;
  final DateTime date;
  final bool rsvp;
  final DateTime createdAt;
  final DateTime updatedAt;

  EventModel({
    required this.id,
    required this.name,
    required this.createdBy,
    required this.inviteAttandee,
    required this.location,
    required this.date,
    required this.rsvp,
    required this.createdAt,
    required this.updatedAt,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      name: json['name'],
      createdBy: json['createdBy'],
      inviteAttandee: json['inviteAttandee'],
      location: json['location'],
      date: DateTime.parse(json['date']),
      rsvp: json['rsvp'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'createdBy': createdBy,
      'inviteAttandee': inviteAttandee,
      'location': location,
      'date': date.toIso8601String(),
      'rsvp': rsvp,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
