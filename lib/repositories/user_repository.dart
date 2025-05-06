import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class UserRepository {
  final http.Client _client;

  UserRepository({http.Client? client}) : _client = client ?? http.Client();

  Future<User> getUser(String userId) async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/users/$userId');
    final response = await _client.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return User.fromJson(data);
    } else {
      throw Exception('Failed to load user data: ${response.statusCode}');
    }
  }
}
