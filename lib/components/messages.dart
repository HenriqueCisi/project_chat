import 'package:flutter/material.dart';
import 'package:project_chat/components/messages_bubble.dart';
import 'package:project_chat/core/models/chat_message.dart';
import 'package:project_chat/core/services/auth/auth_service.dart';
import 'package:project_chat/core/services/chat/chat_service.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = AuthService().currentUser;

    return StreamBuilder<List<ChatMessage>>(
      stream: ChatService().messageStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Start a conversation'));
        } else {
          final msgs = snapshot.data!;

          return ListView.builder(
              reverse: true,
              itemCount: msgs.length,
              itemBuilder: (ctx, index) {
                return MessageBubble(
                  messageKey: msgs[index].id,
                  msg: msgs[index],
                  belongsToCurrentUser:
                      msgs[index].userId == currentUser?.id ? true : false,
                );
              });
        }
      },
    );
  }
}
