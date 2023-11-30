// import 'package:flutter/material.dart';
// import 'dart:async';
// import '../service/websocket_service.dart'; // Import the ApiService

// class ProtestScreen extends StatefulWidget {
//   final WebSocketService webSocketService;

//   ProtestScreen({Key? key, required this.webSocketService}) : super(key: key);

//   @override
//   _ProtestScreenState createState() => _ProtestScreenState();
// }

// class _ProtestScreenState extends State<ProtestScreen> {
//   StreamSubscription? _messageSubscription;

//   @override
//   void initState() {
//     super.initState();
//     _messageSubscription =
//         widget.webSocketService.messageController.stream.listen((message) {
//       // Update your UI with the message data
//     });
//   }

//   @override
//   void dispose() {
//     _messageSubscription?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Build your widget
//   }
// }
