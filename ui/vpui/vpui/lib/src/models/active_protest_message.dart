class ActiveProtestMessage {
  final String? protestId;
  final int participantCountAll;
  final int participantCountActive;

  ActiveProtestMessage(
      {this.protestId,
      required this.participantCountAll,
      required this.participantCountActive});

  factory ActiveProtestMessage.fromJson(Map<String, dynamic> json) {
    return ActiveProtestMessage(
      protestId: json['protestId'] as String?,
      participantCountAll: json['participantCountAll'] as int,
      participantCountActive: json['participantCountActive'] as int,
    );
  }
}
