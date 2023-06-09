import 'package:flutter/material.dart';
import 'package:project_chat/core/services/notification/chat_notification_service.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<ChatNotificationService>(context);
    final items = service.items;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Notifications'),
        ),
        body: ListView.builder(
            itemCount: items.length,
            itemBuilder: ((context, index) {
              return ListTile(
                title: Text(items[index].title),
                subtitle: Text(items[index].body),
                onTap: () => service.remove(index),
              );
            })));
  }
}
