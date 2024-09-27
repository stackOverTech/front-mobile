import 'package:flutter/material.dart';
import 'package:one/functions/get-posts-discipline-filter.dart';
import 'package:one/models/disciplinas.model.dart';
import 'package:one/models/pergunta.model.dart';
import 'package:one/functions/get-posts.dart';
import 'package:one/functions/get-disciplines.dart';
import 'package:one/helpers/appcolors.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

String formatTimeAgo(int tempoDesdeCriacao) {
  if (tempoDesdeCriacao > 24) {
    int dias = (tempoDesdeCriacao / 24).floor();
    return '$dias d';
  } else {
    return '$tempoDesdeCriacao h'; // Retorna em horas
  }
}

class _HomePageState extends State<HomePage> {
  late Future<List<Pergunta>> _postsFuture;
  late Future<List<Disciplina>> _disciplinasFuture;
  String? _disciplinaSelecionada;
  bool _isSearching = false; // Estado da pesquisa
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _postsFuture = fetchPerguntas();
    _disciplinasFuture = fetchDisciplinas();
  }

  void _buscarPerguntasPorDisciplina(int disciplineId) {
    setState(() {
      _postsFuture = fetchPerguntasPorDisciplina(disciplineId);
    });
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(61, 112, 128, 1),
        elevation: 0,
        title: Row(
          children: [
            const Text(
              'One',
              style: TextStyle(height: 24, fontFamily: "Righteous"),
            ),
            const SizedBox(width: 8), // Espaço entre o título e o campo de pesquisa
            if (_isSearching)
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Quer procurar algo?',
                    filled: true,
                    fillColor: AppColors.LIGHT_COLOR,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    hintStyle: const TextStyle(color: AppColors.BACKGROUND_COLOR),
                  ),
                  style: const TextStyle(color: AppColors.BACKGROUND_COLOR),
                ),
              ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: _toggleSearch,
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                color: const Color.fromRGBO(61, 112, 128, 1),
                child: Column(
                  children: [
                    FutureBuilder<List<Disciplina>>(
                      future: _disciplinasFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Erro: ${snapshot.error}'));
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(child: Text('Nenhuma disciplina disponível.'));
                        } else {
                          final disciplinas = snapshot.data!;
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: disciplinas.map((disciplina) {
                                return CategoryChip(
                                  label: disciplina.nome,
                                  disciplineId: disciplina.id,
                                  onTap: () => _buscarPerguntasPorDisciplina(disciplina.id),
                                );
                              }).toList(),
                            ),
                          );
                        }
                      },
                    ),
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
            initialChildSize: 0.85,
            minChildSize: 0.85,
            maxChildSize: 1.0,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      spreadRadius: 5.0,
                      offset: Offset(0.0, -5.0),
                    ),
                  ],
                ),
                child: FutureBuilder<List<Pergunta>>(
                  future: _postsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Erro: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('Nenhuma pergunta disponível.'));
                    } else {
                      final posts = snapshot.data!;
                      return ListView.builder(
                        controller: scrollController,
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          final post = posts[index];
                          return PostCard(
                            image: post.imagem,
                            username: post.usuario,
                            category: post.disciplinas,
                            timeAgo: formatTimeAgo(post.tempoDesdeCriacao),
                            content: post.enunciado,
                            codeSnippet: post.codigo,
                          );
                        },
                      );
                    }
                  },
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
        backgroundColor: const Color.fromRGBO(61, 112, 128, 1),
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  final String label;
  final int disciplineId;
  final VoidCallback onTap;

  const CategoryChip({
    required this.label,
    required this.disciplineId,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: GestureDetector(
        onTap: onTap,
        child: Chip(
          label: Text(
            label,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color.fromRGBO(61, 112, 128, 1),
          shape: const StadiumBorder(side: BorderSide(color: Colors.white)),
        ),
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  final String username;
  final String category;
  final String timeAgo;
  final String content;
  final String? image;
  final String? codeSnippet;

  PostCard({
    required this.username,
    required this.category,
    required this.timeAgo,
    required this.image,
    required this.content,
    this.codeSnippet,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      color: const Color.fromRGBO(238, 238, 238, 1),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  child: Icon(Icons.person),
                ),
                const SizedBox(width: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(username,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(category,
                        style: const TextStyle(
                            color: Color.fromRGBO(97, 46, 88, 1))),
                    Text(timeAgo,
                        style: const TextStyle(
                            color: Color.fromRGBO(91, 94, 85, 1))),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(content),
            if (codeSnippet != null)
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                padding: const EdgeInsets.all(8.0),
                color: Color.fromRGBO(202, 202, 202, 1),
                child: Text(
                  codeSnippet!,
                  style: const TextStyle(fontFamily: 'monospace'),
                ),
              ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.chat_bubble),
                label: const Text('Responder'),
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(61, 112, 128, 1)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
