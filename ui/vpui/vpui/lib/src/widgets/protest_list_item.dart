import 'package:flutter/material.dart';
import '../models/protest.dart';
import 'package:intl/intl.dart'; // Add this for date formatting

class ProtestListItem extends StatelessWidget {
  final Protest protest;

  ProtestListItem({Key? key, required this.protest}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('dd.MM.yyyy – HH:mm').format(protest.date.toLocal());
    int displayCount = protest.isFinished
        ? protest.participantCountAll
        : (protest.isActive ? protest.participantCountActive : -1);

    return Card(
      // Using Card for better visual separation
      child: ListTile(
        title: Text(protest.title),
        subtitle: Text(formattedDate),
        trailing: displayCount >= 0
            ? Text('$displayCount')
            : (protest.isActive
                ? Chip(
                    label: Text('Live',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white)),
                    backgroundColor: Colors.red)
                : null),
      ),
    );
  }
}
