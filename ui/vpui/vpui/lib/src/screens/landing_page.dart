import 'package:flutter/material.dart';
import '../widgets/protest_list_item.dart';
import '../services/protest_service.dart';
import '../models/protest.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final ProtestService protestService = ProtestService();
  late Future<List<Protest>> futureProtests;
  bool showPastProtests = false;

  @override
  void initState() {
    super.initState();
    futureProtests = protestService.fetchProtests();
  }

  List<Protest> filterAndSortProtests(List<Protest> protests, bool showPast) {
    List<Protest> filteredProtests =
        protests.where((p) => showPast ? p.isFinished : !p.isFinished).toList();

    // Sorting logic: Live protests first, then by date
    filteredProtests.sort((a, b) {
      if (a.isActive && !b.isActive) return -1;
      if (!a.isActive && b.isActive) return 1;
      return a.date.compareTo(b.date);
    });

    return filteredProtests;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Virtual Protests')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => setState(() => showPastProtests = false),
                  child: Text('New'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => setState(() => showPastProtests = true),
                  child: Text('Past'),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Protest>>(
              future: futureProtests,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No protests found'));
                } else {
                  List<Protest> filteredProtests =
                      filterAndSortProtests(snapshot.data!, showPastProtests);
                  return ListView.builder(
                    itemCount: filteredProtests.length,
                    itemBuilder: (context, index) {
                      return ProtestListItem(protest: filteredProtests[index]);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
