import 'dart:async'; // Import for Timer
import 'package:flutter/material.dart';
import '../models/protest.dart';
import 'package:intl/intl.dart';

class ProtestListItem extends StatefulWidget {
  final Protest protest;

  ProtestListItem({Key? key, required this.protest}) : super(key: key);

  @override
  _ProtestListItemState createState() => _ProtestListItemState();
}

class _ProtestListItemState extends State<ProtestListItem> {
  Timer? _timer; // Timer is nullable
  String formattedDuration = "";

  @override
  void initState() {
    super.initState();
    // Initialize and start the timer only for active protests
    if (widget.protest.isActive) {
      _updateDuration();
      _timer =
          Timer.periodic(Duration(seconds: 1), (Timer t) => _updateDuration());
    } else {
      // For non-active protests, set a static duration
      final duration = widget.protest.date
          .add(Duration(seconds: widget.protest.durationInSeconds))
          .difference(widget.protest.date);
      formattedDuration =
          "${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}";
    }
  }

  void _updateDuration() {
    if (widget.protest.isActive) {
      final now = DateTime.now();
      final endDate = widget.protest.date
          .add(Duration(seconds: widget.protest.durationInSeconds));
      final remaining = endDate.difference(now);
      setState(() {
        formattedDuration =
            "${remaining.inHours.toString().padLeft(2, '0')}:${(remaining.inMinutes % 60).toString().padLeft(2, '0')}";
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('dd.MM.yyyy HH:mm').format(widget.protest.date.toLocal());
    String durationLabel =
        widget.protest.isActive ? "Remaining: " : "Event Length: ";

    return Card(
      color: widget.protest.isActive
          ? Colors.lightGreen[100]
          : Colors.white, // Distinct background for live protests
      child: ListTile(
        title: Text(
          widget.protest.title,
          style: TextStyle(fontWeight: FontWeight.bold), // Bold title
        ),
        subtitle: Text(
            formattedDate +
                (widget.protest.isFinished
                    ? ''
                    : ' - $durationLabel$formattedDuration'),
            style: widget.protest.isActive
                ? TextStyle(fontWeight: FontWeight.bold)
                : TextStyle(fontWeight: FontWeight.normal)),
        trailing: widget.protest.isActive
            ? Chip(
                label: Text(
                  'Live',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                backgroundColor: Colors.red,
              )
            : null,
      ),
    );
  }
}
