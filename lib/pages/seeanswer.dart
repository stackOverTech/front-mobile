import 'package:flutter/material.dart';
import 'package:one/pages/view_profile.dart';

class SeeAnswerPage extends StatefulWidget {
  final String username;
  final String category;
  final String timeAgo;
  final String content;
  final String? codeSnippet;
  final String? imageUser;
  final String? imageUrl;
  final bool? showReplyButton;
  final List<Map<String, String>> answers;

  const SeeAnswerPage({
    required this.username,
    required this.category,
    required this.timeAgo,
    required this.content,
    this.imageUser,
    this.imageUrl,
    this.codeSnippet,
    this.showReplyButton = false,
    this.answers = const [
      {
        "username": "bruno",
        "timeAgo": "2h",
        "content": "Essa é uma resposta de exemplo.",
        "imageUser": "android/app/src/main/res/drawable/bruninho.png",
        "isBest": "true",
      },
      {
        "username": "bibia",
        "timeAgo": "3h",
        "content": "Outra resposta de exemplo.",
        "imageUser": "android/app/src/main/res/drawable/bibia.png",
        "isBest": "false",
      }
    ],
    super.key,
  });

  @override
  _SeeAnswerPageState createState() => _SeeAnswerPageState();
}

class _SeeAnswerPageState extends State<SeeAnswerPage> {
  List<bool> isLikedList = []; // Inicializa como lista vazia

  @override
  void initState() {
    super.initState();
    // Inicializa isLikedList apenas se answers tiver elementos
    if (widget.answers.isNotEmpty) {
      isLikedList = List<bool>.filled(widget.answers.length, false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(238, 238, 238, 1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(238, 238, 238, 1),
        toolbarHeight: 70,
        leading: IconButton(
          padding: const EdgeInsets.only(left: 15.0),
          icon: Image.asset(
            'android/app/src/main/res/drawable/back_button.png',
            width: 60,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUserProfileCard(),
            const SizedBox(height: 16.0),
            const Text(
              'Respostas',
              style: TextStyle(
                fontSize: 16,
                fontFamily: "Inter",
                fontWeight: FontWeight.w600,
                color: Color(0xFF2C313A),
              ),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: widget.answers.isNotEmpty
                  ? ListView.builder(
                      itemCount: widget.answers.length,
                      itemBuilder: (context, index) {
                        final answer = widget.answers[index];
                        return _buildAnswerCard(answer, index);
                      },
                    )
                  : const Center(child: Text('Nenhuma resposta disponível')),
            ),
            if (widget.showReplyButton == true)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Aqui você pode adicionar a lógica para a ação do botão de resposta
                  },
                  icon: Icon(Icons.chat_bubble_outline),
                  label: Text('Responder'),
                  style: ElevatedButton.styleFrom(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserProfileCard() {
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
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ViewProfile(),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 70),
                    child: widget.imageUser != null
                        ? CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage(widget.imageUser!),
                          )
                        : const CircleAvatar(
                            radius: 20,
                            child: Icon(Icons.person),
                          ),
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.username,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text(
                            widget.category,
                            style: const TextStyle(
                              color: Color.fromRGBO(97, 46, 88, 1),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 5.0),
                          Container(
                            width: 5.0,
                            height: 5.0,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromRGBO(174, 176, 171, 100),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            widget.timeAgo,
                            style: const TextStyle(
                              color: Color.fromRGBO(91, 94, 85, 1),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Text(widget.content),
                      if (widget.imageUrl != null) ...[
                        const SizedBox(height: 8.0),
                        Image.asset(widget.imageUrl!),
                      ],
                      if (widget.codeSnippet != null) ...[
                        const SizedBox(height: 8.0),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(8.0),
                          color: Colors.grey[200],
                          child: Text(
                            widget.codeSnippet!,
                            style: const TextStyle(fontFamily: 'monospace'),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerCard(Map<String, String> answer, int index) {
    final bool isBest = answer['isBest'] == "true";

    // Verificação para evitar acesso fora do índice
    final bool isLiked = isLikedList.isNotEmpty && index < isLikedList.length
        ? isLikedList[index]
        : false;

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: (answer['imageUser'] != null &&
                              answer['imageUser']!.isNotEmpty)
                          ? AssetImage(answer['imageUser']!)
                          : null,
                      child: answer['imageUser'] == null
                          ? const Icon(Icons.person)
                          : null,
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      answer['username'] ?? 'Usuário',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8.0),
                    Container(
                      width: 5.0,
                      height: 5.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(174, 176, 171, 100),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      answer['timeAgo'] ?? '',
                      style: const TextStyle(
                          color: Color.fromRGBO(91, 94, 85, 1),
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Text(answer['content'] ?? ''),
                if (isBest)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: [
                        Icon(Icons.emoji_events, color: Colors.green),
                        const SizedBox(width: 4.0),
                        const Text(
                          'Melhor resposta',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: IconButton(
                icon: SizedBox(
                  width: 25,
                  height: 25,
                  child: Image.asset(
                    isLiked
                        ? 'android/app/src/main/res/drawable/filled_heart.png'
                        : 'android/app/src/main/res/drawable/unfilled_heart.png',
                  ),
                ),
                onPressed: () {
                  setState(() {
                    // Garante que o índice está no range
                    if (index < isLikedList.length) {
                      isLikedList[index] = !isLikedList[index];
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
