import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/disciplinas.model.dart';

Future<List<Disciplina>> fetchDisciplinas() async {
  final response = await http
      .get(Uri.parse('https://back-cyc5.onrender.com/disciplina/all'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => Disciplina.fromJson(data)).toList();
  } else {
    throw Exception('Falha ao carregar disciplinas');
  }
}
