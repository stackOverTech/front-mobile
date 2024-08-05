import 'package:flutter/material.dart';

class NewQuestionPage extends StatefulWidget {
  @override
  _NewQuestionPageState createState() => _NewQuestionPageState();
}

class _NewQuestionPageState extends State<NewQuestionPage> {
  final TextEditingController _contentController = TextEditingController();
  String _selectedCategory = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
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
            const Row(
              children: [
                CircleAvatar(
                  child: Icon(Icons.person),
                ),
                SizedBox(width: 8.0),
                Text('taylor', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
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
            Row(
              children: [
                IconButton(
                  icon:const  Icon(Icons.attach_file),
                  onPressed: () {
                    // Não implementado: funcionalidade de anexo de arquivo
                  },
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (_contentController.text.isNotEmpty && _selectedCategory.isNotEmpty) {
                      Navigator.of(context).pop({
                        'content': _contentController.text,
                        'category': _selectedCategory,
                      });
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            const Text('Vincule a uma disciplina'),
            const SizedBox(height: 8.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CategoryChip(
                    label: 'Banco de Dados',
                    onSelected: () {
                      setState(() {
                        _selectedCategory = 'Banco de Dados';
                      });
                    },
                    selected: _selectedCategory == 'Banco de Dados',
                  ),
                  CategoryChip(
                    label: 'Português',
                    onSelected: () {
                      setState(() {
                        _selectedCategory = 'Português';
                      });
                    },
                    selected: _selectedCategory == 'Português',
                  ),
                  CategoryChip(
                    label: 'Matemática',
                    onSelected: () {
                      setState(() {
                        _selectedCategory = 'Matemática';
                      });
                    },
                    selected: _selectedCategory == 'Matemática',
                  ),
                  CategoryChip(
                    label: 'Inglês',
                    onSelected: () {
                      setState(() {
                        _selectedCategory = 'Inglês';
                      });
                    },
                    selected: _selectedCategory == 'Inglês',
                  ),
                ],
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

  CategoryChip({required this.label, required this.selected, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ChoiceChip(
        label: Text(label, style: TextStyle(color: selected ? Colors.white : Colors.teal)),
        selected: selected,
        onSelected: (bool value) {
          onSelected();
        },
        selectedColor: Colors.teal,
        backgroundColor: Colors.transparent,
        shape: StadiumBorder(side: BorderSide(color: Colors.teal)),
      ),
    );
  }
}
