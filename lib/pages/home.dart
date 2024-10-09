import 'package:flutter/material.dart';
import 'package:one/pages/group.dart';
import 'package:one/pages/monitoring.dart';
import 'package:one/pages/question.dart';

class HomePage extends StatelessWidget {
  void _onSearch(String query) {
    print('Searching for: $query');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            // isso ta armazenando tudo que tem antes do Draggable (elemento de listagem dos posts)
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
                            fontFamily: "Righteous",
                            fontSize: 24,
                            color: Colors.white),
                      ),
                      actions: [
                        SearchExpanded(
                          onSearch: _onSearch,
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
          DraggableScrollableSheet(
            //elemento arrastável e scrollavel de listagem dos posts
            initialChildSize: 0.75,
            // minChildSize: 0.85,
            // maxChildSize: 1.0,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(16.0)),
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
                    PostCard(
                      username: 'lena',
                      category: 'TCC',
                      timeAgo: '2d',
                      content:
                          'Como é que se fala "eu te odeio" em libras mesmo?',
                      codeSnippet: '''
                        print("i hate you")
                        hate()
                      ''',
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
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NewQuestionPage(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white, // Cor do ícone "+"
        ),
        shape: const CircleBorder(),
        backgroundColor: const Color.fromRGBO(61, 112, 128, 1),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: 0,
          onTap: (int index) {
            if (index == 1) {
              // Verifica se o item "book" foi clicado
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MonitoringPage(),
                ),
              );
            }
            if (index == 2) {
              // Verifica se o item "group" foi clicado
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => GroupPage(),
                ),
              );
            }
            if (index == 3) {
              // Verifica se o item "person" foi clicado
              //  Navigator.of(context).push(
              //    MaterialPageRoute(
              //      builder: (context) =>
              //          ProfilePage(),
              //    ),
              //  );
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
          type: BottomNavigationBarType.fixed),
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
                  radius: 20,
                  child: Icon(Icons.person),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            username,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 8.0),
                          Container(
                            width: 5.0,
                            height: 5.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromRGBO(174, 176, 171, 100),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            category,
                            style: const TextStyle(
                                color: Color.fromRGBO(97, 46, 88, 1),
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(width: 4.0),
                          Container(
                            width: 5.0,
                            height: 5.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromRGBO(174, 176, 171, 100),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            timeAgo,
                            style: const TextStyle(
                                color: Color.fromRGBO(91, 94, 85, 1),
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(content),
            if (codeSnippet != null)
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                padding: const EdgeInsets.all(8.0),
                color: const Color.fromRGBO(202, 202, 202, 1),
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
                icon: Image.asset(
                    'android/app/src/main/res/drawable/answer.png',
                    width: 15),
                label: const Text(
                  'Responder',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(61, 112, 128, 1),
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                  minimumSize: const Size(0, 0),
                ).copyWith(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)
                    ),
                  ),
                ),
              ),
            ),
          ],
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
  bool _isSearching = false;

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
        widget.onSearch('');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (_isSearching)
          Container(
            width: 280,
            height: 35,
            child: TextField(
              controller: _searchController,
              onChanged: widget.onSearch,
              decoration: InputDecoration(
                hintText: 'Quer procurar algo?',
                filled: true,
                fillColor: Color.fromRGBO(121, 147, 153, 100),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 10.0),
                hintStyle: const TextStyle(color: Colors.white),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        IconButton(
          icon: Icon(
            _isSearching ? Icons.close : Icons.search,
            color: Colors.white,
          ),
          onPressed: _toggleSearch,
        ),
      ],
    );
  }
}
