import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column( // isso ta armazenando tudo que tem antes do Draggable (elemento de listagem dos posts)
            children: [
              Container(
                color: const Color.fromRGBO(61, 112, 128, 1),
                child: Column(
                  children: [
                    AppBar(
                      automaticallyImplyLeading: false, // some com o back btn
                      backgroundColor: const Color.fromRGBO(61, 112, 128, 1),
                      elevation: 0,
                      title: const Text(
                        'One',
                        style: TextStyle(
                          height: 24,
                          fontFamily: "Righteous"
                        ),
                      ),
                      actions: [
                        IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            
                          },
                        ),
                      ],
                    ),
                    const SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          CategoryChip(label: 'Banco de Dados'),
                          CategoryChip(label: 'Português'),
                          CategoryChip(label: 'Matemática'),
                          CategoryChip(label: 'Engenharia (EQSW)'),
                          CategoryChip(label: 'Inglês'),
                          CategoryChip(label: 'Mobile'),
                        ],
                      ),
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
          DraggableScrollableSheet( //elemento arrastável e scrollavel de listagem dos posts
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
                child: ListView(
                  controller: scrollController,
                  children: [
                    const SizedBox(height: 8),
                    PostCard(
                      username: 'harry',
                      category: 'Banco de Dados',
                      timeAgo: '2h',
                      content: 'Lorem ipsum dolor sit amet consectetur...',
                    ),
                    PostCard(
                      username: 'bruno',
                      category: 'POO',
                      timeAgo: '3h',
                      content: 'Lorem ipsum dolor sit amet consectetur...',
                      codeSnippet: '''
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
                      ''',
                    ),
                    PostCard(
                      username: 'gui',
                      category: 'Inglês',
                      timeAgo: '4h',
                      content: 'Lorem ipsum dolor sit amet consectetur...',
                    ),
                    PostCard(
                      username: 'ana',
                      category: 'Banco de Dados',
                      timeAgo: '1d',
                      content: 'Lorem ipsum dolor sit amet consectetur...',
                    ),
                    PostCard(
                      username: 'bruno',
                      category: 'Inglês',
                      timeAgo: '1d',
                      content: 'Lorem ipsum dolor sit amet consectetur...',
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
        },
        child: Icon(Icons.add),
        backgroundColor: const Color.fromRGBO(61, 112, 128, 1),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  final String label;

  const CategoryChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Chip(
        label: Text(label, style: const TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromRGBO(61, 112, 128, 1),
        shape: const StadiumBorder(side: BorderSide(color: Colors.white)),
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  final String username;
  final String category;
  final String timeAgo;
  final String content;
  final String? codeSnippet;

  PostCard({
    required this.username,
    required this.category,
    required this.timeAgo,
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
                    Text(username, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(category, style: const TextStyle(color: Color.fromRGBO(97, 46, 88, 1))),
                    Text(timeAgo, style: const TextStyle(color: Color.fromRGBO(91, 94, 85, 1))),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(content),
            if (codeSnippet != null)
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0), //horizontal: 8.0 não ta querendo
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
                onPressed: () {
                  
                },
                icon: const Icon(Icons.chat_bubble),
                label: const Text('Responder'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(61, 112, 128, 1)
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
