import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:one/home.dart' as myhome;
import 'package:one/pages/group.dart';
import 'package:one/pages/monitoring.dart';
import 'package:one/pages/profile.dart';
import 'package:one/pages/question.dart';

class Post {
  final int id;
  final String enunciado;
  final String codigo;
  final String imagem;
  final String dataCriacao;
  final Usuario usuario;
  final Disciplinas disciplinas;
  final int tempoDesdeCriacao;
  final int numeroRespostas;

  Post({
    required this.id,
    required this.enunciado,
    required this.codigo,
    required this.imagem,
    required this.dataCriacao,
    required this.usuario,
    required this.disciplinas,
    required this.tempoDesdeCriacao,
    required this.numeroRespostas,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      enunciado: json['enunciado'],
      codigo: json['codigo'],
      imagem: json['imagem'],
      dataCriacao: json['data_criacao'],
      usuario: Usuario.fromJson(json['usuario']),
      disciplinas: Disciplinas.fromJson(json['disciplinas']),
      tempoDesdeCriacao: json['tempoDesdeCriacao'],
      numeroRespostas: json['numeroRespostas'],
    );
  }
}

class Usuario {
  final String nome;
  final String foto;

  Usuario({
    required this.nome,
    required this.foto,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      nome: json['nome'],
      foto: json['foto'],
    );
  }
}

class Disciplinas {
  final String nome;

  Disciplinas({
    required this.nome,
  });

  factory Disciplinas.fromJson(Map<String, dynamic> json) {
    return Disciplinas(
      nome: json['nome'],
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedDiscipline = '';
  List<String> _disciplines = [];
  List<Post> _posts = [];
  Map<String, int> _disciplineIds = {};
  bool _isLoading = false;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _fetchPosts();
    _fetchDisciplines(); // Buscar disciplinas do CHIP (antes da página/ não mover isso)
  }

  Future<void> _fetchDisciplines() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http
        .get(Uri.parse('https://back-cyc5.onrender.com/disciplina/all'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        _disciplines = data.map((item) => item['nome'] as String).toList();
        _disciplineIds = {for (var d in data) d['nome']: d['id']};
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Falha ao carregar disciplinas');
    }
  }

  Future<void> _fetchPosts({int? disciplinaId}) async {
    setState(() {
      _isLoading = true;
    });

    final url = disciplinaId != null
        ? 'https://back-cyc5.onrender.com/pergunta/all?disciplinaId=$disciplinaId'
        : 'https://back-cyc5.onrender.com/pergunta/all';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        _posts = data.map((item) => Post.fromJson(item)).toList();
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Falha ao carregar postagens');
    }
  }

  void _onDisciplineSelected(String discipline) {
    setState(() {
      _selectedDiscipline = discipline;
    });

    final disciplineId = _disciplineIds[discipline];
    if (disciplineId != null) {
      _fetchPosts(disciplinaId: disciplineId);
    } else {
      _fetchPosts();
    }
  }

  Widget _buildDisciplineSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _disciplines.map((discipline) {
              return myhome.CategoryChip(
                label: discipline,
                selected: _selectedDiscipline == discipline,
                onSelected: (selected) {
                  _onDisciplineSelected(discipline);
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                color: const Color.fromRGBO(61, 112, 128, 1),
                child: Column(
                  children: [
                    AppBar(
                      automaticallyImplyLeading: false,
                      backgroundColor: const Color.fromRGBO(61, 112, 128, 1),
                      elevation: 0,
                      title: const Text(
                        'One',
                        style: TextStyle(
                            fontFamily: "Righteous",
                            fontSize: 24,
                            color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildDisciplineSelector(),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: const Color.fromRGBO(61, 112, 128, 1),
                ),
              ),
            ],
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.75,
            minChildSize: 0.75,
            maxChildSize: 1.00,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(24.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      spreadRadius: 5.0,
                      offset: Offset(0.0, -5.0),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Image.asset(
                        'android/app/src/main/res/drawable/home_detail.png',
                        width: 70,
                      ),
                    ),
                    _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : Expanded(
                            child: ListView(
                              controller: scrollController,
                              children: _posts.map((post) {
                                return myhome.PostCard(
                                  username: post.usuario.nome,
                                  category: post.disciplinas.nome,
                                  timeAgo: _getTimeAgo(post.tempoDesdeCriacao),
                                  content: post.enunciado,
                                );
                              }).toList(),
                            ),
                          ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 0) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => HomePage(),
            ));
          } else if (index == 1) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MonitoringPage(),
            ));
          } else if (index == 2) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => GroupPage(),
            ));
          } else if (index == 3) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProfilePage(),
            ));
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
      floatingActionButton: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 60.0, bottom: 7.0),
            child: ConstrainedBox(
              constraints:
                  const BoxConstraints.tightFor(width: 150, height: 40),
              child: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => NewQuestionPage(),
                    ),
                  );
                },
                backgroundColor: Colors.grey[600],
                foregroundColor: Colors.white,
                label: const Text(
                  'Faça sua pergunta',
                  style: TextStyle(fontSize: 14),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Positioned(
            child: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => NewQuestionPage(),
                  ),
                );
              },
              backgroundColor: const Color.fromRGBO(61, 112, 128, 1),
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              shape: const CircleBorder(),
            ),
          ),
        ],
      ),
    );
  }

  String _getTimeAgo(int seconds) {
    final duration = Duration(seconds: seconds);
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    return '$hours hrs $minutes min ago';
  }
}
