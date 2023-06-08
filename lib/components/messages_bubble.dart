import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_chat/core/models/chat_message.dart';

class MessageBubble extends StatelessWidget {
  static const defaultUserImage = 'assets/images/avatar.png';
  final ChatMessage msg;
  final bool belongsToCurrentUser;
  final String messageKey;

  const MessageBubble(
      {super.key,
      required this.msg,
      required this.belongsToCurrentUser,
      required this.messageKey});


  Widget _showUserImage(String imageURL){
    ImageProvider? provider;
    final uri = Uri.parse(imageURL.toString());

    if(uri.path.contains(defaultUserImage)){
      provider = AssetImage(uri.toString());
    }
    else if(uri.scheme.contains('http')){
      provider = NetworkImage(uri.toString());
    }
    else{
      provider = FileImage(File(uri.toString()));
    }

    return CircleAvatar(
            backgroundImage: provider,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: belongsToCurrentUser
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Container(
                decoration: BoxDecoration(
                  color: belongsToCurrentUser
                      ? Colors.grey.shade300
                      : Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(12),
                    topRight: const Radius.circular(12),
                    bottomLeft: belongsToCurrentUser ? const Radius.circular(12) : const Radius.circular(0),
                    bottomRight: belongsToCurrentUser ? const Radius.circular(0) : const Radius.circular(12)
                    ),
                ),
                width: 180,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                child: Column(
                  crossAxisAlignment: belongsToCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Text(
                      msg.userName,
                      style: TextStyle(
                          color: belongsToCurrentUser ? Colors.black : Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      msg.text,
                      textAlign: belongsToCurrentUser ? TextAlign.right : TextAlign.left,
                      style: TextStyle(
                        color: belongsToCurrentUser ? Colors.black : Colors.white,
                      ),
                    ),
                  ],
                )),
          ],
        ),
        Positioned(
          top: 0,
          left: belongsToCurrentUser ? null : 165,
          right: belongsToCurrentUser ? 165 : null,
          child: _showUserImage(msg.userImageURL),
        ),
      ],
    );
  }
}
