import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/user.dart';

class UserRepository {
  final String baseUrl = "https://jsonplaceholder.typicode.com";

  Future<List<UserModel>> fetchUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => UserModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<UserModel> createUser(UserModel user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      body: jsonEncode(user.toJson()),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 201) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create user');
    }
  }

  Future<UserModel> updateUser(UserModel user) async {
    final response = await http.put(
      Uri.parse('$baseUrl/users/${user.id}'),
      body: jsonEncode(user.toJson()),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update user');
    }
  }

  Future<void> deleteUser(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/users/$id'));
    if (response.statusCode == 200) {
      print('User deleted successfully');
    } else {
      print('Failed to delete user. Status code: ${response.statusCode}');
      throw Exception('Failed to delete user');
    }
  }
}
