import 'dart:async';
import 'dart:math';

import 'package:project_chat/core/models/chat_message.dart';
import 'package:project_chat/core/models/chat_user.dart';
import 'package:project_chat/core/services/chat/chat_service.dart';

class ChatMockService implements ChatService {
  static final List<ChatMessage> _msgs = [
    // ChatMessage(
    //     id: '1',
    //     text: 'Rapaizz',
    //     createdAt: DateTime.now(),
    //     userId: '100',
    //     userName: 'Henrique',
    //     userImageURL: 'assets/images/avatar.png'),
    // ChatMessage(
    //     id: '2',
    //     text: 'Qual foi?',
    //     createdAt: DateTime.now(),
    //     userId: '101',
    //     userName: 'Teste2',
    //     userImageURL: 'assets/images/avatar.png'),
    // ChatMessage(
    //     id: '3',
    //     text: 'Uepa',
    //     createdAt: DateTime.now(),
    //     userId: '100',
    //     userName: 'Henrique',
    //     userImageURL: 'assets/images/avatar.png'),
  ];

  static MultiStreamController<List<ChatMessage>>? _controller;

  static final _msgsStream = Stream<List<ChatMessage>>.multi((controller) {
    _controller = controller;
    controller.add(_msgs);
  });

  @override
  Stream<List<ChatMessage>> messageStream() {
    return _msgsStream;
  }

  Future<ChatMessage> save(String text, ChatUser user) async {
    final newMessage = ChatMessage(
        id: Random().nextDouble().toString(),
        text: text,
        createdAt: DateTime.now(),
        userId: user.id,
        userName: user.name,
        userImageURL: user.imageURL);

    _msgs.add(newMessage);

    _controller?.add(_msgs.reversed.toList());

    return newMessage;
  }
}
