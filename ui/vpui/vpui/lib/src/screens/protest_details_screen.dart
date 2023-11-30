import 'dart:async';
import 'package:flutter/material.dart';
import '../models/protest.dart';
import 'package:intl/intl.dart';

class ProtestDetailsScreen extends StatefulWidget {
  final Protest protest;

  ProtestDetailsScreen({Key? key, required this.protest}) : super(key: key);

  @override
  _ProtestDetailsScreenState createState() => _ProtestDetailsScreenState();
}

class _ProtestDetailsScreenState extends State<ProtestDetailsScreen> {
  Timer? _timer;
  String formattedDuration = "";

  @override
  void initState() {
    super.initState();
    if (widget.protest.isActive) {
      _updateDuration();
      _timer =
          Timer.periodic(Duration(seconds: 1), (Timer t) => _updateDuration());
    } else {
      _setDuration();
    }
  }

  void _updateDuration() {
    final now = DateTime.now();
    final endDate = widget.protest.date
        .add(Duration(seconds: widget.protest.durationInSeconds));
    final remaining = endDate.difference(now);
    setState(() {
      formattedDuration =
          "${remaining.inHours.toString().padLeft(2, '0')}:${(remaining.inMinutes % 60).toString().padLeft(2, '0')}";
    });
  }

  void _setDuration() {
    final duration = widget.protest.date
        .add(Duration(seconds: widget.protest.durationInSeconds))
        .difference(widget.protest.date);
    formattedDuration =
        "${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.protest.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (widget.protest.isActive)
              Chip(
                label: Text(
                  'Live',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                backgroundColor: Colors.red,
              ),
            SizedBox(height: 10),
            Text(
              'Description:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(widget.protest.description),
            SizedBox(height: 10),
            Text(
              'Start:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(DateFormat('yyyy-MM-dd – HH:mm')
                .format(widget.protest.date.toLocal())),
            SizedBox(height: 10),
            Text(
              widget.protest.isActive ? 'Remaining:' : 'Event Length:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(formattedDuration),
            SizedBox(height: 10),
            Text(
              'Participants:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(widget.protest.isActive
                ? '${widget.protest.participantCountActive}'
                : '${widget.protest.participantCountAll}'),
            SizedBox(height: 20),
            if (widget.protest.isActive)
              ElevatedButton(
                onPressed: () {
                  // TODO: Implement join action
                },
                child: Text('Join Protest'),
              ),
          ],
        ),
      ),
    );
  }
}
