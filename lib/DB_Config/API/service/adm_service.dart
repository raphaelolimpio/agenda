import 'dart:convert';
import 'package:http/http.dart' as http;

class AdmService {
  final String baseUrl = 'http://127.0.0.1:3000/adm';

  Future<Map<String, dynamic>> getAdmById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 404) {
      throw Exception('Failed');
    } else {
      throw Exception('Failed to load Adm');
    }
  }

  Future<void> addAdm(Map<String, dynamic> adm) async {
    print(adm);
    final response = await http.post(
      Uri.parse('$baseUrl'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(adm),
    );
    if (response.statusCode == 201) {
      print("Adm created successfully");
    } else {
      throw Exception('Failed to add adm');
    }
  }

  Future<void> deleteAdm(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      print("Adm deleted whit sucess");
    } else {
      throw Exception('Failed to delete adm');
    }
  }

  Future<void> updateAdm(int id, Map<String, dynamic> adm) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(adm),
    );
    if (response.statusCode == 200) {
      print("Adm updated whit sucess");
    } else {
      throw Exception('Failed to update adm');
    }
  }

  Future<Map<String, dynamic>> loginAdm(String email, String senha) async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/login/adm'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'senha': senha}),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to login');
    }
  }
}
