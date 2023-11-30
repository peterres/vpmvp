import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../models/protest.dart';

class ProtestService {
  final String baseUrl = 'https://vpbackend.azurewebsites.net/Protest';
  final int maxRetries = 1; // Maximum number of retries
  final int retryDelaySeconds = 1; // Delay in seconds between retries

  Future<List<Protest>> fetchProtests() async {
    int retryCount = 0;
    while (retryCount < maxRetries) {
      try {
        final response = await http.get(Uri.parse(baseUrl));
        if (response.statusCode == 200) {
          List<dynamic> protestsJson = json.decode(response.body);
          return protestsJson.map((json) => Protest.fromJson(json)).toList();
        } else {
          throw Exception('Failed to load protests');
        }
      } catch (e) {
        retryCount++;
        if (retryCount >= maxRetries) {
          throw Exception('Failed to load protests after $maxRetries retries');
        }
        await Future.delayed(Duration(seconds: retryDelaySeconds));
      }
    }
    throw Exception('Failed to load protests');
  }
}
