import 'dart:convert';
import 'package:http/http.dart' as http;

Future<bool> postQuestion({
  required int idUsuario,
  required int idDisciplina,
  required int idInstituicao,
  required String enunciado,
  String? imagem,
  String? codigo,
}) async {
  final url = Uri.parse('https://back-cyc5.onrender.com/pergunta/');

  final Map<String, dynamic> body = {
    "id_usuario": idUsuario,
    "id_disciplina": idDisciplina,
    "id_instituicao": idInstituicao,
    "enunciado": enunciado,
    "imagem": imagem ?? "",
    "codigo": codigo ?? ""
  };

  // Logando o corpo para verificar o que está sendo enviado
  print('Enviando o seguinte corpo: ${json.encode(body)}');

  try {
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(body),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      // Log the response body for debugging
      print('Erro: ${response.statusCode} - ${response.body}');
      return false;
    }
  } catch (e) {
    // Handle network or other exceptions
    print('Erro ao enviar a requisição: $e');
    return false;
  }
}
