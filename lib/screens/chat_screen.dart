import 'package:flutter/material.dart';
import 'package:day_10/service/gemini_api.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ChatUser user1 = ChatUser(id: '1', firstName: 'me');
  ChatUser user2 = ChatUser(id: '2', firstName: 'bot');

  List<ChatMessage> messagesList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text('chatBot', style: TextStyle(color: Colors.white)),
        actions: [Icon(Icons.menu, color: Colors.white)],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/ba.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: DashChat(
          messageOptions: MessageOptions(
            avatarBuilder: (p0, onPressAvatar, onLongPressAvatar) {
              return CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/images/Av.jpg'),
              );
            },
          ),

          currentUser: user1,
          onSend: (messages) async {
            messagesList.insert(0, messages);
            setState(() {});

            String botMessage = await GeminiApi().sendRequest(messages.text);
            ChatMessage reply = ChatMessage(
              user: user2,
              createdAt: DateTime.now(),
              text: botMessage,
            );
            messagesList.insert(0, reply);
            setState(() {});
          },
          messages: messagesList,
        ),
      ),
    );
  }
}