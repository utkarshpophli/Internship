import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user.dart';

class ApiService {
  final String apiUrl = "https://reqres.in/api";

  Future<List<User>> getUsers() async {
    final response = await http.get('$apiUrl/users?page=2' as Uri);

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body)['data'];
      List<User> users = body.map((dynamic item) => User.fromJson(item)).toList();
      return users;
    } else {
      throw "Failed to load users list";
    }
  }

  Future<User> createUser(String name, String job) async {
    final response = await http.post(
      '$apiUrl/users' as Uri,
      body: jsonEncode(<String, String>{
        'name': name,
        'job': job,
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw "Failed to create user";
    }
  }
}