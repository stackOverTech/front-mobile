import 'package:flutter/material.dart';
import 'package:one/home.dart';

class SeeAnswerPage extends StatelessWidget {
  final String username;
  final String category;
  final String timeAgo;
  final String content;
  final String? imageUser;
  final String? imageUrl;
  final String? codeSnippet;
  final bool showReplyButton;
  final List<Map<String, String>> answers;

  const SeeAnswerPage({
    required this.username,
    required this.category,
    required this.timeAgo,
    required this.content,
    this.imageUser,
    this.imageUrl,
    this.codeSnippet,
    this.showReplyButton = true,
    this.answers = const [
      {
        "username": "bruno",
        "timeAgo": "1h",
        "content": "Essa é uma resposta de exemplo.",
        "imageUser": "android/app/src/main/res/drawable/bruninho.png",
        "isBest": "true",
        "likes": "3",
      },
      {
        "username": "taylor",
        "timeAgo": "2h",
        "content": "Outra resposta de exemplo.",
        "imageUser": "android/app/src/main/res/drawable/taylor.png",
        "isBest": "false",
        "likes": "2",
      },
      {
        "username": "bibia",
        "timeAgo": "3h",
        "content": "Outra resposta de exemplo.",
        "imageUser": "android/app/src/main/res/drawable/bibia.png",
        "isBest": "false",
        "likes": "1", // Número inicial de curtidas
      }
    ],
    Key? key,
  }) : super(key: key);

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
            PostCard(
              // Utilize o PostCard aqui
              username: username,
              category: category,
              timeAgo: timeAgo,
              content: content,
              imageUser: imageUser,
              imageUrl: imageUrl,
              codeSnippet: codeSnippet,
              showReplyButton: showReplyButton,
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                'Respostas (${answers.length})',
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF2C313A),
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: answers.isNotEmpty
                  ? ListView.builder(
                      itemCount: answers.length,
                      itemBuilder: (context, index) {
                        final answer = answers[index];
                        return _buildAnswerCard(answer);
                      },
                    )
                  : const Center(child: Text('Nenhuma resposta disponível')),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerCard(Map<String, String> answer) {
    final bool isBest = answer['isBest'] == "true";

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: AssetImage(answer['imageUser'] ?? ''),
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
                      style: TextStyle(color: Colors.green),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
