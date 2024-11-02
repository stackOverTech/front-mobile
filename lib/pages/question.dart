import 'package:flutter/material.dart';
import 'package:one/functions/get-disciplines.dart';
import 'package:one/functions/post-questions.dart';
import 'package:one/models/disciplinas.model.dart';

class NewQuestionPage extends StatefulWidget {
  @override
  _NewQuestionPageState createState() => _NewQuestionPageState();
}

class _NewQuestionPageState extends State<NewQuestionPage> {
  final TextEditingController _contentController = TextEditingController();
  List<Disciplina> _disciplinas = [];
  Disciplina? _selectedDisciplina;

  @override
  void initState() {
    super.initState();
    _loadDisciplinas();
  }

  Future<void> _loadDisciplinas() async {
    try {
      final disciplinas = await fetchDisciplinas();
      setState(() {
        _disciplinas = disciplinas;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar disciplinas')),
      );
    }
  }

  Future<void> _submitQuestion() async {
    if (_selectedDisciplina != null && _contentController.text.isNotEmpty) {
      final success = await postQuestion(
        idUsuario: 1,
        idDisciplina: _selectedDisciplina!.id,
        idInstituicao: 1,
        enunciado: _contentController.text,
        imagem: "http://url",
        codigo: "SELECT * FROM popopo",
      );

      if (!success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao enviar a pergunta')),
        );
      } else {
        // Limpar o campo após enviar
        _contentController.clear();
        setState(() {
          _selectedDisciplina = null; // Limpar a seleção da disciplina
        });

        // Retornar à tela anterior
        Navigator.of(context).pop(); // Adicione esta linha
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Retorna à tela anterior
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16.0),
            TextField(
              controller: _contentController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Escreva aqui sua pergunta...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            const Text('Vincule a uma disciplina'),
            const SizedBox(height: 8.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _disciplinas.map((disciplina) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDisciplina = _selectedDisciplina == disciplina
                            ? null
                            : disciplina;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: _selectedDisciplina == disciplina
                            ? Colors.teal
                            : Colors.transparent,
                        border: Border.all(color: Colors.teal),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Text(
                        disciplina.nome,
                        style: TextStyle(
                          color: _selectedDisciplina == disciplina
                              ? Colors.white
                              : Colors.teal,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16.0),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () async {
                  await _submitQuestion();
                },
                child: const Text('Enviar Pergunta'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
