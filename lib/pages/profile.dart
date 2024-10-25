import 'package:flutter/material.dart';

import 'group.dart';
import 'home.dart';
import 'monitoring.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin {
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
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              _buildTopSection(),
              const Positioned(
                top: 100, // Ajustando a posição para a foto de perfil
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('one/android/app/src/main/res/drawable/profile.png'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 70), // Espaço para a imagem sobreposta
          _buildUserInfo(),
          TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            indicatorColor: Colors.black,
            unselectedLabelColor: Colors.grey,
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
        currentIndex: 3, // Current index set to 3 for the profile page
        onTap: (int index) {
          if (index == 0) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
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

  // Seção superior com a cor de fundo verde
  Widget _buildTopSection() {
    return Container(
      height: 130,
      color: const Color.fromRGBO(61, 112, 128, 1), // Cor verde do topo sem bordas arredondadas
    );
  }

  // Informações do usuário (nome, idade e série)
  Widget _buildUserInfo() {
    return Column(
      children: const [
        Text(
          'Taylor',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Text(
          '17 anos\n3ºD Tech',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildRankingTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Perguntas Mais Respondidas',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildRankingPodium(), // Alteração aqui para a exibição do pódio 3D
          const SizedBox(height: 16),
          _buildBadgeList(),
        ],
      ),
    );
  }

  Widget _buildRankingPodium() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end, // Alinha a parte de baixo dos itens
      children: [
        _buildRankingBox('2º', 'ziza', const Color.fromARGB(255, 20, 67, 105), 60), // 2º lugar
        const SizedBox(width: 8),
        _buildRankingBox('1º', 'bibia', const Color.fromARGB(255, 117, 20, 13), 80), // 1º lugar sobreposto
        const SizedBox(width: 8),
        _buildRankingBox('3º', 'taylor', const Color.fromARGB(255, 180, 124, 40), 60), // 3º lugar
      ],
    );
  }

  Widget _buildRankingBox(String position, String name, Color color, double height) {
    return Container(
      height: height,
      width: 70,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
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
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.emoji_events, color: Colors.yellow),
          title: const Text('4º harry'),
        ),
        ListTile(
          leading: const Icon(Icons.emoji_events, color: Colors.yellow),
          title: const Text('5º taylor'),
        ),
        ListTile(
          leading: const Icon(Icons.emoji_events, color: Colors.yellow),
          title: const Text('6º modolo'),
        ),
      ],
    );
  }

  Widget _buildPublicacoesTab() {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (context, index) {
        return PostCard(username: "Taylor", category: "category", timeAgo: "timeAgo", content: "content", isProfile: true,);
      },
    );
  }

  Widget _buildMonitoriaTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Você ainda não é um monitor :(',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField(
            items: [
              DropdownMenuItem(child: Text('Matéria 1'), value: 'mat1'),
              DropdownMenuItem(child: Text('Matéria 2'), value: 'mat2'),
            ],
            onChanged: (value) {},
            decoration: InputDecoration(labelText: 'Matéria *'),
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(labelText: 'Por que você quer ser monitor dessa matéria? *'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Lógica de envio
            },
            child: const Text('Enviar Solicitação'),
          ),
        ],
      ),
    );
  }
}