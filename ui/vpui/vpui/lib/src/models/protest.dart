class Protest {
  final String id;
  final String title;
  final DateTime date;
  final int participantCountAll;
  final int participantCountActive;
  final bool isActive;
  final bool isFinished;
  final int durationInSeconds;

  Protest({
    required this.id,
    required this.title,
    required this.date,
    required this.participantCountAll,
    required this.participantCountActive,
    required this.isActive,
    required this.isFinished,
    required this.durationInSeconds, // Constructor parameter
  });

  factory Protest.fromJson(Map<String, dynamic> json) {
    return Protest(
      id: json['id'],
      title: json['title'],
      date: DateTime.parse(json['date']),
      participantCountAll: json['participantCountAll'],
      participantCountActive: json['participantCountActive'],
      isActive: json['isActive'],
      isFinished: json['isFinished'],
      durationInSeconds: json['durationInSeconds'], // JSON parsing
    );
  }
}
