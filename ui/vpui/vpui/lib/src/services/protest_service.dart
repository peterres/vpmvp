import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/protest.dart';

class ProtestService {
  final String baseUrl = 'https://vpbackend.azurewebsites.net/Protest';

  Future<List<Protest>> fetchProtests() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> protestsJson = json.decode(response.body);
      return protestsJson.map((json) => Protest.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load protests');
    }
  }
}
