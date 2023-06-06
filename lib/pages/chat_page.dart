import 'package:flutter/material.dart';
import 'package:project_chat/components/messages.dart';
import 'package:project_chat/components/new_message.dart';
import 'package:project_chat/core/services/auth/auth_service.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ZIP ZAP'),
          actions: [
            DropdownButton(
                icon: Icon(Icons.more_vert,
                    color: Theme.of(context).primaryIconTheme.color),
                items: [
                  DropdownMenuItem(
                      value: 'logout',
                      child: Row(children: const [
                        Icon(Icons.exit_to_app, color: Colors.black,),
                        SizedBox(width: 10),
                        Text('Logout')
                      ])),
                ],
                onChanged: (value) {
                  if (value == 'logout') {
                    AuthService().logout();
                  }
                })
          ],
        ),
        body: SafeArea(
            child: Column(
          children: const [
            Expanded(child: Messages()),
            NewMessage(),
          ],
        )));
  }
}
