import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/pet_model.dart';

class PetController {
  static const String baseUrl =
      'https://pet-adopt-dq32j.ondigitalocean.app/pet';

  // Recupera o token salvo no SharedPreferences
  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  // Busca pets com suporte a paginação
  Future<List<PetModel>> fetchPets({int page = 1, int limit = 10}) async {
    final url = Uri.parse('$baseUrl/pets?page=$page&limit=$limit');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> petsList = data['pets'] ?? [];
      return petsList.map((json) => PetModel.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar os pets: ${response.body}');
    }
  }

  // Adiciona um novo pet
  Future<void> addPet({
    required String name,
    required int age,
    required double weight,
    required String color,
    required List<String> images,
  }) async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('Token não encontrado. Faça login novamente.');
    }

    final response = await http.post(
      Uri.parse('$baseUrl/create'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'name': name,
        'age': age,
        'weight': weight,
        'color': color,
        'images': images,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Falha ao cadastrar o pet: ${response.body}');
    }
  }

  // Exclui um pet pelo ID
  Future<void> deletePet(String petId) async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('Token não encontrado. Faça login novamente.');
    }

    final response = await http.delete(
      Uri.parse('$baseUrl/delete/$petId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao excluir o pet: ${response.body}');
    }
  }

  // Atualiza informações de um pet pelo ID
  Future<void> updatePet({
    required String petId,
    required String name,
    required int age,
    required double weight,
    required String color,
    required List<String> images,
  }) async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('Token não encontrado. Faça login novamente.');
    }

    final response = await http.put(
      Uri.parse('$baseUrl/update/$petId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'name': name,
        'age': age,
        'weight': weight,
        'color': color,
        'images': images,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao atualizar o pet: ${response.body}');
    }
  }
}