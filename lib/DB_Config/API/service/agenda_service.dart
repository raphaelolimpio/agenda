import 'dart:convert';
import 'package:http/http.dart' as http;

class AgendaService {
  final String baseUrl = 'http://localhost:3000//agenda';

  Future<List> getAgend() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load agenda');
    }
  }

  Future<Map<String, dynamic>> getAdgendById(int id) async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 404) {
      throw Exception('Failed');
    } else {
      throw Exception('Failed to load agenda');
    }
  }

  Future<void> addAdgend(Map<String, dynamic> agenda) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(agenda),
    );
    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to add agenda');
    }
  }

  Future<void> deleteAdgend(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      print("Agenda deleted whit sucess");
    } else {
      throw Exception('Failed to delete agenda');
    }
  }

  Future<void> updateAdgend(int id, Map<String, dynamic> agenda) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'aplication/json'},
      body: json.encode(agenda),
    );
    if (response.statusCode == 200) {
      print("Agenda updated whit sucess");
    } else {
      throw Exception('Failed to update agenda');
    }
  }
}
