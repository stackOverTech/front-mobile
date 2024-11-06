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
        "timeAgo": "1h",
        "content": "Essa é uma resposta de exemplo.",
        "imageUser": "android/app/src/main/res/drawable/bruninho.png",
        "isBest": "true",
        "likes": "3", // Número inicial de curtidas
      },
      {
        "username": "taylor",
        "timeAgo": "2h",
        "content": "Outra resposta de exemplo.",
        "imageUser": "android/app/src/main/res/drawable/taylor.png",
        "isBest": "false",
        "likes": "2", // Número inicial de curtidas
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
    super.key,
  });

  @override
  _SeeAnswerPageState createState() => _SeeAnswerPageState();
}

class _SeeAnswerPageState extends State<SeeAnswerPage> {
  List<bool> isLikedList = [];
  List<int> likeCountList = [];

  @override
  void initState() {
    super.initState();
    if (widget.answers.isNotEmpty) {
      isLikedList = List<bool>.filled(widget.answers.length, false);
      likeCountList = widget.answers.map((answer) {
        print("Likes: ${answer['likes']}"); // Debug: imprime o número de likes
        return int.parse(answer['likes'] ?? '0');
      }).toList();
    }
    print(
        "Number of answers: ${widget.answers.length}"); // Debug: imprime o número de respostas
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
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                'Respostas (${widget.answers.length})', // Altere para widget.answers.length
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
              child: widget.answers.isNotEmpty
                  ? ListView.builder(
                      itemCount: widget.answers.length,
                      itemBuilder: (context, index) {
                        final answer = widget.answers[index];
                        print(
                            "Construindo card para: ${answer['username']}"); // Debug
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
    print("Index: $index, Answer: ${answer['username']}"); // Debug
    if (index >= isLikedList.length || index >= likeCountList.length) {
      return const SizedBox(); // Retorna um widget vazio se o índice for inválido
    }

    final bool isBest = answer['isBest'] == "true";
    final int likeCount = likeCountList[index];

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
                          style: TextStyle(color: Colors.green),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            Positioned(
              bottom: 0,
              right: 12,
              child: Row(
                children: [
                  IconButton(
                    icon: Image.asset(
                      width: 20,
                      isLikedList[index]
                          ? 'android/app/src/main/res/drawable/filled_heart.png'
                          : 'android/app/src/main/res/drawable/unfilled_heart.png',
                    ),
                    onPressed: () {
                      setState(() {
                        isLikedList[index] = !isLikedList[index];
                        if (isLikedList[index]) {
                          likeCountList[
                              index]++; // Incrementa o contador de likes
                        } else {
                          likeCountList[
                              index]--; // Decrementa o contador de likes
                        }
                      });
                    },
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    likeCount.toString(),
                    style: const TextStyle(fontWeight: FontWeight.w500),
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
