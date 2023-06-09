import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project_chat/components/messages.dart';
import 'package:project_chat/components/new_message.dart';
import 'package:project_chat/core/models/chat_notification.dart';
import 'package:project_chat/core/services/auth/auth_service.dart';
import 'package:project_chat/core/services/notification/chat_notification_service.dart';
import 'package:project_chat/pages/notification_page.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ZIP ZAP'),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
                icon: Icon(Icons.more_vert,
                    color: Theme.of(context).primaryIconTheme.color),
                items: [
                  DropdownMenuItem(
                      value: 'logout',
                      child: Row(children: const [
                        Icon(
                          Icons.exit_to_app,
                          color: Colors.black,
                        ),
                        SizedBox(width: 10),
                        Text('Logout')
                      ])),
                ],
                onChanged: (value) {
                  if (value == 'logout') {
                    AuthService().logout();
                  }
                }),
          ),
          Stack(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => const NotificationPage()));
                  },
                  icon: const Icon(Icons.notifications)),
              Positioned(
                top: 5,
                right: 5,
                child: CircleAvatar(
                  maxRadius: 10,
                  backgroundColor: Colors.red.shade800,
                  child: Text(
                    '${Provider.of<ChatNotificationService>(context).itemsCount}',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              )
            ],
          )
        ],
      ),
      body: SafeArea(
          child: Column(
        children: const [
          Expanded(child: Messages()),
          NewMessage(),
        ],
      )),
    );
  }
}
