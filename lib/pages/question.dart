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
      backgroundColor: const Color(0xFFFDFDFD),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFFDFDFD),
        toolbarHeight: 70,
        leading: IconButton(
          padding: const EdgeInsets.only(left: 15.0),
          icon: Image.asset(
              width: 60,
              'android/app/src/main/res/drawable/back_button_grey.png'),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserProfileRow(
              username: 'taylor',
              imageUser: 'android/app/src/main/res/drawable/taylor.png',
            ),
            const SizedBox(height: 16.0),
            Container(
              constraints: BoxConstraints(
                maxWidth: 380,
                minWidth: 350,
              ),
              child: Column(
                children: [
                  Container(
                    height: 190,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Stack(
                      children: [
                        TextField(
                          controller: _contentController,
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText: 'Escreva aqui sua pergunta...',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 20.0),
                          ),
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16.0,
                            color: Colors.black87,
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 16,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Image.asset(
                                  'android/app/src/main/res/drawable/anexo.png',
                                  width: 30,
                                  height: 30,
                                ),
                                onPressed: () {
                                  // Não implementado: funcionalidade de anexo de arquivo
                                },
                              ),
                              IconButton(
                                icon: Image.asset(
                                  'android/app/src/main/res/drawable/enviar.png',
                                  width: 35,
                                  height: 35,
                                ),
                                onPressed: () {
                                  _sendFeedback(context);
                                  if (_contentController.text.isNotEmpty) {
                                    Navigator.of(context).pop({
                                      'content': _contentController.text,
                                      'category': _selectedDisciplina,
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24.0),
                ],
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

class CategoryChip extends StatelessWidget {
  final String label;
  final bool selected;
  final Function onSelected;

  CategoryChip(
      {required this.label, required this.selected, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: FilterChip(
        label: Text(
          label,
          style: TextStyle(
            color:
                selected ? Colors.white : const Color.fromRGBO(61, 112, 128, 1),
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        selected: selected,
        onSelected: (bool value) {
          onSelected();
        },
        selectedColor: const Color.fromRGBO(61, 112, 128, 1),
        backgroundColor: const Color(0xFFFDFDFD),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(
            color: const Color.fromRGBO(61, 112, 128, 1),
            width: 2.0,
          ),
        ),
      ),
    );
  }
}

class UserProfileRow extends StatelessWidget {
  final String username;
  final String? imageUser;

  const UserProfileRow({
    Key? key,
    required this.username,
    this.imageUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          child: ClipOval(
            child: imageUser != null
                ? Image.asset(
                    imageUser!,
                    fit: BoxFit.cover,
                    width: 40,
                    height: 40,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.person, size: 40);
                    },
                  )
                : const Icon(Icons.person, size: 40),
          ),
        ),
        const SizedBox(width: 8.0),
        Text(
          username,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

void _sendFeedback(BuildContext context) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Material(
        elevation: 6.0,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.15,
          color: const Color(0xFFFDFDFD),
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Pergunta publicada!',
                style: TextStyle(fontSize: 20, color: Color(0xFF2C313A)),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);

  Future.delayed(const Duration(seconds: 2), () {
    overlayEntry.remove();
  });
}
