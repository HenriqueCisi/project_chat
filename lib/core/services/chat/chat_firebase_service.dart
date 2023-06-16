import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_chat/core/models/chat_message.dart';
import 'package:project_chat/core/models/chat_user.dart';
import 'package:project_chat/core/services/chat/chat_service.dart';

class ChatFirebaseService implements ChatService {
  static final List<ChatMessage> _msgs = [];

  @override
  Stream<List<ChatMessage>> messageStream() {
    return const Stream<List<ChatMessage>>.empty();
  }

  Future<ChatMessage?> save(String text, ChatUser user) async {
    final store = FirebaseFirestore.instance;

    // CHATMESSAGE -> MAP <STRING, DYNAMIC>
    final docRef = await store.collection('chat').add({
      ' text': text,
      'createdAt': DateTime.now().toIso8601String(),
      ' userId': user.id,
      ' userName': user.name,
      'userImageURL': user.imageURL
    });

    final doc = await docRef.get();
    final data = doc.data()!;

    return ChatMessage(
        id: doc.id,
        text: data['text'],
        createdAt: DateTime.parse(data['createdAt']),
        userId: data['userId'],
        userName: data['userName'],
        userImageURL: data['userImageURL']);
  }
}
