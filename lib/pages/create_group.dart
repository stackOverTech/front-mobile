import 'package:flutter/material.dart';

class CreateGroupPage extends StatefulWidget {
  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroupPage> {
  final TextEditingController _groupNameController = TextEditingController();
  final TextEditingController _groupDetailsController = TextEditingController();
  final TextEditingController _groupParticipantsController =
      TextEditingController();
  String _selectedDiscipline = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Criar grupo',
          style: TextStyle(
            color: Color(0xFF2C313A),
            fontWeight: FontWeight.w500,
            fontFamily: "Inter",
            fontSize: 26,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Image.asset(
              'android/app/src/main/res/drawable/back_button_grey.png'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildAvatar(),
            const SizedBox(height: 26),
            _buildTextField('Nome do grupo', _groupNameController),
            const SizedBox(height: 12),
            _buildTextField('Detalhes do grupo', _groupDetailsController),
            const SizedBox(height: 12),
            _buildTextField(
                'Integrantes do grupo', _groupParticipantsController),
            const SizedBox(height: 12),
            _buildDisciplineSelector(),
            const SizedBox(height: 12),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: SizedBox(
          width: 260,
          child: FloatingActionButton.extended(
            onPressed: () {
              _sendFeedback(context);
            },
            backgroundColor: Color.fromRGBO(61, 112, 128, 1),
            foregroundColor: const Color(0xFFFDFDFD),
            elevation: 8.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.0),
            ),
            label: const Text(
              'Criar',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: <Widget>[
          const CircleAvatar(
            radius: 75,
            backgroundColor: Color(0xFFEAE9E9),
          ),
          IconButton(
            icon: const Icon(Icons.camera_alt),
            iconSize: 45,
            color: const Color(0xFF4A4848),
            onPressed: () {
              _showAvatarDialog();
            },
          ),
        ],
      ),
    );
  }

  void _showAvatarDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFFDFDFD),
        title: const Text('Trocar foto de perfil'),
        content: const Text('Você pode trocar a foto de perfil aqui.'),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '$label ',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                fontFamily: "Inter",
                color: Color(0xFF2C313A),
              ),
            ),
            const Text(
              '*',
              style: TextStyle(
                color: Color.fromRGBO(187, 76, 83, 100),
                fontWeight: FontWeight.w900,
                fontSize: 20,
                fontFamily: "Inter",
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(
                color: Color.fromRGBO(61, 112, 128, 1),
                width: 2.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(
                color: Color.fromRGBO(61, 112, 128, 1),
                width: 2.0,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDisciplineSelector() {
    const disciplines = ['Banco de Dados', 'Português', 'Matemática', 'Inglês'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Text(
              'Vincule a uma disciplina ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                fontFamily: "Inter",
                color: Color(0xFF2C313A),
              ),
            ),
            Text(
              '*',
              style: TextStyle(
                color: Color.fromRGBO(187, 76, 83, 100),
                fontWeight: FontWeight.w900,
                fontSize: 20,
                fontFamily: "Inter",
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: disciplines.map((discipline) {
              return CategoryChip(
                label: discipline,
                selected: _selectedDiscipline == discipline,
                onSelected: (selected) {
                  setState(() {
                    _selectedDiscipline = selected ? discipline : '';
                  });
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  void _sendFeedback(BuildContext context) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 20,
        child: Material(
          elevation: 6.0,
          child: Container(
            width: MediaQuery.of(context).size.width, 
            color: const Color(0xFFFDFDFD),
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, 
              children: [
                Image.asset(
                  'android/app/src/main/res/drawable/task_alt.png',
                  width: 100,
                  height: 40,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Criado com sucesso!',
                  style: TextStyle(fontSize: 24, color: Color(0xFF2C313A)),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
      Navigator.pop(context);
    });
  }
}

class CategoryChip extends StatelessWidget {
  final String label;
  final bool selected;
  final ValueChanged<bool> onSelected;

  const CategoryChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: FilterChip(
        label: Text(label),
        selected: selected,
        onSelected: onSelected,
        selectedColor: const Color.fromRGBO(61, 112, 128, 1),
        labelStyle: TextStyle(
            color:
                selected ? Colors.white : const Color.fromRGBO(61, 112, 128, 1),
            fontSize: 16.0,
            fontWeight: FontWeight.bold),
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
