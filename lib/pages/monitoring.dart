import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:one/pages/group.dart';
import 'package:one/pages/home.dart';
import '../models/disciplinas.model.dart';

class MonitoringPage extends StatefulWidget {
  @override
  _MonitoringPageState createState() => _MonitoringPageState();
}

class _MonitoringPageState extends State<MonitoringPage> {
  String userProfile = 'aluno';
  String studentName = '';
  String teacherName = '';
  String monitorName = '';
  List<Disciplina> _disciplinas = [];

  @override
  void initState() {
    super.initState();
    fetchNamesFromDatabase();
    fetchDisciplinas(); // Chama a função para buscar as disciplinas
  }

  void fetchNamesFromDatabase() async {
    setState(() {
      studentName = 'Taylor';
      teacherName = 'Grilo';
      monitorName = 'Harry';
    });
  }

  Future<void> fetchDisciplinas() async {
    final response = await http
        .get(Uri.parse('https://back-cyc5.onrender.com/disciplina/all'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      setState(() {
        _disciplinas =
            jsonResponse.map((data) => Disciplina.fromJson(data)).toList();
      });
    } else {
      throw Exception('Falha ao carregar disciplinas');
    }
  }

  Color _getRandomColor() {
    const List<Color> colors = [
      Color(0xFFBB4C53),
      Color(0xFF7E4987),
      Color(0xFF305A77),
      Color(0xFFD27051),
      Color.fromARGB(255, 48, 119, 82),
      Color.fromARGB(255, 119, 48, 81),
    ];

    return colors[Random().nextInt(colors.length)];
  }

  void _onSearch(String query) {
    print('Searching for: $query');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: const Color.fromRGBO(61, 112, 128, 1),
            title: const Text(
              'One',
              style: TextStyle(
                fontFamily: "Righteous",
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            actions: [
              SearchExpanded(
                onSearch: _onSearch,
              ),
            ],
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(253, 253, 253, 1.0),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(61, 112, 128, 1),
                    spreadRadius: 12,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userProfile == 'aluno'
                        ? '$studentName, sua \nmonitoria te \nespera :)'
                        : userProfile == 'professor'
                            ? '$teacherName, fique de olho \nno andamento das \nmonitorias :)'
                            : '$monitorName, fique de olho \nno andamento das \nsuas monitorias :)',
                    style: const TextStyle(
                      fontSize: 24,
                      fontFamily: "inter",
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2C313A),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Se for monitor, adiciona mais uma coluna de disciplinas
                  if (userProfile == 'monitor') ...[
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Agenda de monitorias',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              SizedBox(width: 16),
                              SubjectCard(
                                title: 'Biologia',
                                color: Color.fromARGB(255, 48, 119, 82),
                              ),
                              SizedBox(width: 16),
                              SubjectCard(
                                title: 'Geografia',
                                color: Color.fromARGB(255, 119, 48, 81),
                              ),
                              SizedBox(width: 16),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],

                  // Disciplinas Existentes (Para todos os perfis)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Disciplinas Existentes',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ..._disciplinas.map((disciplina) {
                              // Aplica a cor aleatória para cada disciplina
                              Color randomColor = _getRandomColor();
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: SubjectCard(
                                  title: disciplina.nome,
                                  color: randomColor, // Aplica a cor aleatória
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userProfile == 'professor'
                            ? 'Disciplinas que você acompanha' // Para professor
                            : 'Disciplinas que recebo monitoria', // Para aluno e monitor
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: const [
                            SubjectCard(
                              title: 'DAD',
                              color: Color(0xFF305A77),
                            ),
                            SizedBox(width: 16),
                            SubjectCard(
                              title: 'Português',
                              color: Color(0xFFD27051),
                            ),
                            SizedBox(width: 16),
                            SubjectCard(
                              title: 'Matemática',
                              color: Color(0xFFBB4C53),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (int index) {
          if (index == 0) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          } else if (index == 2) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => GroupPage(),
              ),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
        selectedItemColor: const Color.fromRGBO(61, 112, 128, 1),
        unselectedItemColor: Colors.white,
        backgroundColor: const Color.fromRGBO(72, 79, 92, 1.0),
        elevation: 10,
        selectedIconTheme: const IconThemeData(size: 24, weight: 24),
        unselectedIconTheme: const IconThemeData(size: 24, weight: 24),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

class SubjectCard extends StatelessWidget {
  final String title;
  final Color color;

  const SubjectCard({required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 100,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class SearchExpanded extends StatefulWidget {
  final Function(String) onSearch;

  const SearchExpanded({required this.onSearch});

  @override
  _SearchExpandedState createState() => _SearchExpandedState();
}

class _SearchExpandedState extends State<SearchExpanded> {
  final TextEditingController _searchController = TextEditingController();
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: _isExpanded ? 300 : 50,
        height: 40,
        child: Row(
          children: [
            if (_isExpanded)
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Buscar',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: widget.onSearch,
                ),
              ),
            Icon(
              _isExpanded ? Icons.close : Icons.search,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
