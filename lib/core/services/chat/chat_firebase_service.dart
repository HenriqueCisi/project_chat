import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_chat/core/models/chat_message.dart';
import 'package:project_chat/core/models/chat_user.dart';
import 'package:project_chat/core/services/chat/chat_service.dart';

class ChatFirebaseService implements ChatService {
  static final List<ChatMessage> _msgs = [];

  @override
  Stream<List<ChatMessage>> messageStream() {
    final store = FirebaseFirestore.instance;

    final snapshots = store
        .collection('chat')
        .withConverter(fromFirestore: _fromFirestore, toFirestore: _toFirestore)
        .orderBy('createdAt')
        .snapshots();

    return snapshots.map((snapshot) {
      return snapshot.docs.map((doc) {
        return doc.data();
      }).toList();
    });
  }

  @override
  Future<ChatMessage?> save(String text, ChatUser user) async {
    final store = FirebaseFirestore.instance;

    final msg = ChatMessage(
        id: '',
        text: text,
        createdAt: DateTime.now(),
        userId: user.id,
        userName: user.name,
        userImageURL: user.imageURL);

    // CHATMESSAGE -> MAP <STRING, DYNAMIC>
    final docRef = await store
        .collection('chat')
        .withConverter(fromFirestore: _fromFirestore, toFirestore: _toFirestore)
        .add(msg);

    final doc = await docRef.get();
    return doc.data()!;
  }

  // MAP <STRING, DYNAMIC> -> CHATMESSAGE
  ChatMessage _fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc, SnapshotOptions? options) {
    return ChatMessage(
        id: doc.data()!.containsKey('id') ? doc.id : '',
        text: doc.data()!.containsKey('text') ? doc['text'] : '',
        createdAt: doc.data()!.containsKey('createdAt')
            ? DateTime.parse(doc['createdAt'])
            : DateTime.now(),
        userId: doc.data()!.containsKey('userId') ? doc['userId'] : '',
        userName: doc.data()!.containsKey('userName') ? doc['userName'] : '',
        userImageURL:
            doc.data()!.containsKey('userImageURL') ? doc['userImageURL'] : '');
  }

  // CHATMESSAGE -> MAP <STRING, DYNAMIC>
  Map<String, dynamic> _toFirestore(ChatMessage message, SetOptions? options) {
    return {
      'text': message.text,
      'createdAt': message.createdAt.toIso8601String(),
      'userId': message.userId,
      'userName': message.userName,
      'userImageURL': message.userImageURL
    };
  }
}
