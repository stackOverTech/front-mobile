import 'package:flutter/material.dart';
import 'package:one/helpers/appcolors.dart';
import 'package:one/pages/edit_profile.dart';
import 'package:one/pages/post-card.dart';
import 'package:url_launcher/url_launcher.dart';

import 'group.dart';
import 'monitoring.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              _buildTopSection(),
              const Positioned(
                top: 90,
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage(
                    'android/app/src/main/res/drawable/taylor.png',
                  ),
                ),
              ),
              Positioned(
                top: 200,
                right: 130,
                child: _buildEditButton(context),
              ),
            ],
          ),
          const SizedBox(height: 80),
          _buildUserInfo(),
          const SizedBox(height: 20),
          TabBar(
            controller: _tabController,
            labelColor: const Color(0xFF2C313A),
            unselectedLabelColor: const Color.fromARGB(255, 75, 75, 75),
            indicatorColor: const Color.fromRGBO(61, 112, 128, 1),
            indicatorWeight: 2.0,
            indicatorPadding: const EdgeInsets.symmetric(horizontal: 0),
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16.0,
              fontFamily: "Inter",
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.normal,
            ),
            tabs: const [
              Tab(text: 'Ranking'),
              Tab(text: 'Publicações'),
              Tab(text: 'Monitoria'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildRankingTab(),
                _buildPublicacoesTab(),
                _buildMonitoriaTab(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        onTap: (int index) {
          if (index == 0) {
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) => HomePage(),
            //   ),
            // );
          }
          if (index == 1) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MonitoringPage(),
              ),
            );
          }
          if (index == 2) {
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

  Widget _buildTopSection() {
    return Stack(
      children: [
        Container(
          height: 200,
          color: const Color.fromRGBO(61, 112, 128, 1), // Cor verde
        ),
        Positioned(
          top: 150,
          left: 0,
          right: 0,
          child: Container(
            height: 50,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserInfo() {
    return Column(
      children: const [
        Text(
          'Taylor',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        Text(
          '17 anos\n3ºD Tech',
          style: TextStyle(fontSize: 16, color: Color(0xFF2C313A)),
        ),
      ],
    );
  }

  Widget _buildRankingTab() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 16.0),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.BLACK_TEXT, width: 1),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Text(
            'Perguntas Mais Respondidas',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18.0,
              fontFamily: "Inter",
            ),
          ),
        ),
        const SizedBox(height: 15),
        _buildRankingPodium(),
        const SizedBox(height: 16),
        _buildBadgeList(),
      ],
    );
  }

  Widget _buildRankingPodium() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildRankingBox(
            '2º', 'ziza', const Color.fromARGB(255, 48, 89, 119), 70),
        const SizedBox(width: 8),
        _buildRankingBox(
            '1º', 'bibia', const Color.fromARGB(255, 187, 76, 83), 90),
        const SizedBox(width: 8),
        _buildRankingBox('3º', 'taylor', Color.fromRGBO(210, 111, 81, 1), 70),
      ],
    );
  }

  Widget _buildRankingBox(
      String position, String name, Color color, double height) {
    return Container(
      height: height,
      width: 80,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            position,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            name,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildBadgeList() {
    final badges = [
      '4º harry',
      '5º cris',
      '6º bruninho',
    ];

    return Column(
      children: List.generate(badges.length, (index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0, right: 20, left: 20),
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.BLACK_TEXT, width: 1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ListTile(
              leading: Image.asset(
                'android/app/src/main/res/drawable/medal.png',
                width: 24,
                height: 24,
              ),
              title: Text(
                badges[index],
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18.0,
                  fontFamily: "Inter",
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildPublicacoesTab() {
    final List<Map<String, String>> posts = [
      {
        "username": "taylor",
        "category": "Banco de Dados",
        "timeAgo": "2h",
        "content": "Fiz um DELETE sem WHERE e agora",
        "imageUser": 'android/app/src/main/res/drawable/taylor.png',
      },
      {
        "username": "taylor",
        "category": "Inglês",
        "timeAgo": "5h",
        "content": "Qual expressão é usada para falar 'vou dormir' em inglês?",
        "imageUser": 'android/app/src/main/res/drawable/taylor.png',
      },
      {
        "username": "taylor",
        "category": "Matemática",
        "timeAgo": "1d",
        "content": "Como uso bhaskara?",
        "imageUser": 'android/app/src/main/res/drawable/taylor.png',
      },
      {
        "username": "taylor",
        "category": "Física",
        "timeAgo": "1d",
        "content": "Qual a segunda lei de Newton?",
        "imageUser": 'android/app/src/main/res/drawable/taylor.png',
      },
    ];

    return ListView.builder(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return PostCard(
            username: posts[index]["username"]!,
            category: posts[index]["category"]!,
            timeAgo: posts[index]["timeAgo"]!,
            content: posts[index]["content"]!);
      },
    );
  }

  Widget _buildMonitoriaTab() {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            'Você ainda não é um monitor :(',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 30),
          Text(
            'Acesse o forms abaixo para\nfazer sua solicitação!',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 30),
          InkWell(
            onTap: _launchURL,
            child: Text(
              'https://forms.gle/bRrQG4rJDABrG8JU9',
              style: TextStyle(
                fontSize: 18,
                color: Colors.blue,
                decoration: TextDecoration.underline,
                decorationColor: Colors.blue,
              ),
            ),
          )

          // DropdownButtonFormField(
          //   items: [
          //     DropdownMenuItem(value: 'mat1', child: Text('Matéria 1')),
          //     DropdownMenuItem(value: 'mat2', child: Text('Matéria 2')),
          //   ],
          //   onChanged: (value) {},
          //   decoration: InputDecoration(labelText: 'Matéria *'),
          // ),
          // const SizedBox(height: 16),
          // TextField(
          //   decoration: InputDecoration(
          //       labelText: 'Por que você quer ser monitor dessa matéria? *'),
          // ),
          // const SizedBox(height: 16),
          // ElevatedButton(
          //   onPressed: () {
          //     // Lógica de envio
          //   },
          //   child: const Text('Enviar Solicitação'),
          // ),
        ],
      ),
    );
  }
}

Widget _buildEditButton(BuildContext context) {
  return InkWell(
    borderRadius: BorderRadius.circular(40), // Para efeito de clique circular
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EditProfilePage(),
        ),
      );
    },
    child: CircleAvatar(
      radius: 25,
      backgroundColor: const Color.fromARGB(255, 198, 198, 198),
      child: const Icon(Icons.edit, color: Colors.black),
    ),
  );
}

void _launchURL() async {
  final Uri url = Uri.parse('https://forms.gle/bRrQG4rJDABrG8JU9');
  if (!await launchUrl(url)) {
    throw 'Could not launch $url';
  }
}
