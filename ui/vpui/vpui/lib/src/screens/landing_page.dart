import 'package:flutter/material.dart';
import 'dart:async';
import '../widgets/protest_list_item.dart';
import '../services/protest_service.dart';
import '../models/protest.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final ProtestService protestService = ProtestService();
  List<Protest> protests = [];
  bool showPastProtests = false;
  bool isLoading = true;
  bool _loadingFailed = false;
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _fetchProtests();
    _startAutoRefresh();
  }

  void _startAutoRefresh() {
    _refreshTimer = Timer.periodic(Duration(seconds: 5), (Timer t) {
      _fetchProtests();
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  Future<void> _fetchProtests() async {
    try {
      List<Protest> fetchedProtests = await protestService.fetchProtests();
      setState(() {
        protests = fetchedProtests;
        isLoading = false;
        _loadingFailed = false;
      });
    } catch (error) {
      setState(() {
        _loadingFailed = true;
        isLoading = false;
      });
    }
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
    List<Protest> filteredProtests =
        filterAndSortProtests(protests, showPastProtests);

    return Scaffold(
      appBar: AppBar(title: Text('Virtual Protests')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _listButton('New', !showPastProtests),
                SizedBox(width: 8),
                _listButton('Past', showPastProtests),
              ],
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : _loadingFailed
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Failed to load protests. Please try again.'),
                            ElevatedButton(
                              onPressed: _fetchProtests,
                              child: Text('Retry'),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredProtests.length,
                        itemBuilder: (context, index) {
                          return ProtestListItem(
                              protest: filteredProtests[index]);
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _listButton(String title, bool isActive) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          showPastProtests = (title == 'Past');
          isLoading = true;
          _fetchProtests();
        });
      },
      style: ElevatedButton.styleFrom(
        primary: isActive ? Colors.blue : Colors.grey,
        onPrimary:
            isActive ? Colors.white : Colors.black, // Text color for contrast
      ),
      child: Text(title),
    );
  }
}
