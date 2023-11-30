import 'package:flutter/material.dart';
import '../models/protest.dart';
import '../widgets/animated_heartbeat_image.dart';
import '../services/websocket_service.dart';

class ActiveProtestScreen extends StatefulWidget {
  final Protest protest;

  ActiveProtestScreen({Key? key, required this.protest}) : super(key: key);

  @override
  _ActiveProtestScreenState createState() => _ActiveProtestScreenState();
}

class _ActiveProtestScreenState extends State<ActiveProtestScreen> {
  late WebSocketService _webSocketService;
  int _currentParticipantCount = 0;

  @override
  void initState() {
    super.initState();
    _joinProtest();
  }

  void _joinProtest() {
    _webSocketService = WebSocketService(
        'ws://vpbackend.azurewebsites.net/ws/join?protestId=${widget.protest.id}');
    _webSocketService.connect();
    _webSocketService.messageController.stream.listen((message) {
      if (message.protestId == widget.protest.id) {
        setState(() {
          _currentParticipantCount = message.participantCountActive;
        });
      }
    });
  }

  void _leaveProtest() {
    _webSocketService.close();
  }

  @override
  void dispose() {
    _leaveProtest();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Active Protest', textAlign: TextAlign.center),
      ),
      body: Center(
        // Centering content
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              widget.protest.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              textAlign: TextAlign.center,
            ),
            // Dynamic visual element placeholder
            Center(child: AnimatedHeartbeatImage()),
            Text(
              '$_currentParticipantCount',
              style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            ElevatedButton(
              onPressed: () {
                _leaveProtest();
                Navigator.pop(context); // Navigate back to details screen
              },
              child: Text('Leave Protest'),
            ),
          ],
        ),
      ),
    );
  }
}