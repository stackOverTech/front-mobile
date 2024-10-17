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
                                horizontal: 16.0, vertical: 10.0),
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
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24.0),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 12.0),
              child: const Text(
                'Vincule a uma disciplina',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16.0,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            SingleChildScrollView(
              padding: const EdgeInsets.only(
                  left: 12.0),
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
