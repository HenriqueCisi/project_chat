import 'dart:io';

import 'package:project_chat/core/models/chat_user.dart';

abstract class AuthService {
  ChatUser? get currentUser;

  Stream<ChatUser?> get userChanges;

  Future<void> signup(String name, String password, String email, File image);

  Future<void> login(String email, String password);

  Future<void> logout();
}
