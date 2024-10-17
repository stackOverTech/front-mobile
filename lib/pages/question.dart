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
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserProfileRow(
              username: 'taylor',
              imageUser: 'android/app/src/main/res/drawable/taylor.png',
            ),
            const SizedBox(height: 16.0),
            Expanded(
              flex: 0, 
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 380, 
                  minWidth: 350, 
                ),
                child: TextField(
                  controller: _contentController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Escreva aqui sua pergunta...',
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(15.0), 
                      borderSide: BorderSide.none, 
                    ),
                  ),
                  style: TextStyle(
                    fontFamily:
                        'Inter', 
                    fontSize: 16.0,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.attach_file),
                  onPressed: () {
                    // Não implementado: funcionalidade de anexo de arquivo
                  },
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (_contentController.text.isNotEmpty &&
                        _selectedCategory.isNotEmpty) {
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

  CategoryChip(
      {required this.label, required this.selected, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ChoiceChip(
        label: Text(label,
            style: TextStyle(color: selected ? Colors.white : Colors.teal)),
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
