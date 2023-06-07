import 'package:flutter/material.dart';
import 'package:project_chat/core/models/chat_message.dart';
import 'package:project_chat/core/services/chat/chat_service.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ChatMessage>>(
      stream: ChatService().messageStream(),
      builder: (context, snapshot) {

        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator());
        }
        else if(!snapshot.hasData || snapshot.data!.isEmpty){
          return const Center(child: Text('Start a conversation'));
        }
        else{
          final msgs = snapshot.data!;

          return ListView.builder(
            reverse: true,
            itemCount:  msgs.length,
            itemBuilder: (ctx, index) {
              return Text(msgs[index].text);
            });
        }

        
      },);
  }
}