import 'package:project_chat/core/models/chat_message.dart';
import 'package:project_chat/core/models/chat_user.dart';
import 'package:project_chat/core/services/chat/chat_firebase_service.dart';

abstract class ChatService {
  Stream<List<ChatMessage>> messageStream();
  Future<ChatMessage?>save(String text, ChatUser user);

  factory ChatService(){
    return ChatFirebaseService();
  }
}