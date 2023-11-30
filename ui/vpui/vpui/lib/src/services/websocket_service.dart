import 'dart:convert';
import 'dart:async';
import 'package:web_socket_channel/io.dart';

class WebSocketService {
  final String url;
  late IOWebSocketChannel channel;
  StreamController<ActiveProtestMessage> messageController =
      StreamController.broadcast();

  WebSocketService(this.url);

  void connect() {
    channel = IOWebSocketChannel.connect(url);
    channel.stream.listen((data) {
      final jsonData = json.decode(data) as Map<String, dynamic>;
      final message = ActiveProtestMessage.fromJson(jsonData);
      messageController.add(message);
    });
  }

  void close() {
    messageController.close();
    channel.sink.close();
  }
}

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
