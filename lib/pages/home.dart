import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

// HomePage

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

  @override
  void initState() {
    super.initState();
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

  // Função para buscar postagens (perguntas) por disciplina
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
              return CategoryChip(
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
                                return PostCard(
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
    );
  }

  String _getTimeAgo(int seconds) {
    final duration = Duration(seconds: seconds);
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    return '$hours h $minutes min';
  }
}

class CategoryChip extends StatelessWidget {
  final String label;
  final bool selected;
  final ValueChanged<bool> onSelected;

  const CategoryChip({
    Key? key,
    required this.label,
    required this.selected,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: onSelected,
      selectedColor: Colors.blue,
      labelStyle: TextStyle(
        color: selected ? Colors.white : Colors.black,
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  final String username;
  final String category;
  final String timeAgo;
  final String content;

  const PostCard({
    Key? key,
    required this.username,
    required this.category,
    required this.timeAgo,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text(username[0],
                      style: const TextStyle(color: Colors.white)),
                ),
                const SizedBox(width: 8),
                Text(username,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(width: 8),
                Text('• $timeAgo', style: const TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 8),
            Text(category,
                style: const TextStyle(fontSize: 14, color: Colors.blue)),
            const SizedBox(height: 8),
            Text(content),
          ],
        ),
      ),
    );
  }
}
