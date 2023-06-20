import 'package:flutter/material.dart';
import 'package:project_chat/core/models/chat_user.dart';
import 'package:project_chat/core/services/auth/auth_service.dart';
import 'package:project_chat/core/services/notification/chat_notification_service.dart';
import 'package:project_chat/pages/auth.page.dart';
import 'package:project_chat/pages/chat_page.dart';
import 'package:project_chat/pages/loading.page.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

class AuthOrAppPage extends StatelessWidget {
  const AuthOrAppPage({super.key});

  Future<void> _init(BuildContext context) async {
    await Firebase.initializeApp();
    await Provider.of<ChatNotificationService>(context, listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _init(context),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingPage();
        } else {
          return StreamBuilder<ChatUser?>(
              stream: AuthService().userChanges,
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingPage();
                } else {
                  return snapshot.hasData ? const ChatPage() : const AuthPage();
                }
              });
        }
      },
    );
  }
}
