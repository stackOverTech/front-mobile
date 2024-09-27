import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:one/models/pergunta.model.dart';

Future<List<Pergunta>> fetchPerguntasPorDisciplina(int disciplinaId) async {
  final response = await http.get(Uri.parse(
      'https://back-cyc5.onrender.com/pergunta/all?disciplinaId=$disciplinaId'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => Pergunta.fromJson(data)).toList();
  } else {
    throw Exception('Falha ao carregar perguntas');
  }
}
