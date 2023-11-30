import 'package:flutter/material.dart';
import '../services/api_service.dart'; // Import the ApiService

class SampleItemDetailsView extends StatefulWidget {
  const SampleItemDetailsView({Key? key}) : super(key: key);

  static const routeName = '/sample_item';

  @override
  _SampleItemDetailsViewState createState() => _SampleItemDetailsViewState();
}

class _SampleItemDetailsViewState extends State<SampleItemDetailsView> {
  String _data = 'Loading...';

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    try {
      String data = await ApiService().fetchData();
      setState(() {
        _data = data;
      });
    } catch (e) {
      setState(() {
        _data = 'Failed to fetch data';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details'),
      ),
      body: Center(
        child: Text(_data), // Display the fetched data
      ),
    );
  }
}
