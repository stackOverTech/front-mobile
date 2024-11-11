import 'package:flutter/material.dart';
import 'package:one/pages/question.dart';
import 'package:one/pages/view_profile.dart';

class AnswerPage extends StatefulWidget {
  final String username;
  final String category;
  final String timeAgo;
  final String content;
  final String? codeSnippet;
  final String? imageUser;
  final String? imageUrl;
  final bool? showReplyButton;

  const AnswerPage({
    required this.username,
    required this.category,
    required this.timeAgo,
    required this.content,
    this.imageUser,
    this.imageUrl,
    this.codeSnippet,
    this.showReplyButton = false,
    super.key,
  });

  @override
  _AnswerPageState createState() => _AnswerPageState();
}

class _AnswerPageState extends State<AnswerPage> {
  final TextEditingController _answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFFDFDFD),
        toolbarHeight: 70,
        leading: IconButton(
          padding: const EdgeInsets.only(left: 15.0),
          icon: Image.asset(
            'android/app/src/main/res/drawable/back_button_grey.png',
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
            _buildAnswerInput(),
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
                            decoration: BoxDecoration(
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

  Widget _buildAnswerInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10.0),
        const Padding(
          padding: EdgeInsets.only(left: 26.0),
          child: UserProfileRow(
            username: 'taylor',
            imageUser: 'android/app/src/main/res/drawable/taylor.png',
          ),
        ),
        const SizedBox(height: 15.0),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Stack(
            children: [
              Container(
                height: 190,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: TextField(
                  controller: _answerController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Escreva aqui sua resposta...',
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                  ),
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16.0,
                    color: Colors.black87,
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 16,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Image.asset(
                        'android/app/src/main/res/drawable/anexo.png',
                        width: 30,
                        height: 30,
                      ),
                      onPressed: () {
                        // Não implementado: funcionalidade de anexo de arquivo
                      },
                    ),
                    IconButton(
                      icon: Image.asset(
                        'android/app/src/main/res/drawable/enviar.png',
                        width: 35,
                        height: 35,
                      ),
                      onPressed: () {
                        _sendFeedback(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

void _sendFeedback(BuildContext context) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Material(
        elevation: 6.0,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.15,
          color: const Color(0xFFFDFDFD),
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Resposta publicada!',
                style: TextStyle(fontSize: 20, color: Color(0xFF2C313A)),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);

  Future.delayed(const Duration(seconds: 3), () {
    overlayEntry.remove();
    Navigator.pop(context);
  });
}
