import 'package:http/http.dart' as http;

class ApiService {
  Future<String> fetchData() async {
    final response = await http
        .get(Uri.parse('https://vpbackend.azurewebsites.net/Protest'));

    if (response.statusCode == 200) {
      // Process the response body
      return response.body;
    } else {
      // Handle server error
      throw Exception('Failed to load data from API');
    }
  }
}
