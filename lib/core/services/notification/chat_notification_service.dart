import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:project_chat/core/models/chat_notification.dart';

class ChatNotificationService with ChangeNotifier {
  List<ChatNotification> _items = [];

  List<ChatNotification> get items {
    return [..._items];
  }

  void add(ChatNotification notification) {
    _items.add(notification);
    notifyListeners();
  }

  void remove(int i) {
    _items.removeAt(i);
    notifyListeners();
  }

  int get itemsCount {
    return _items.length;
  }

  //Push Notifications
  Future<void> init() async {
    await _configureTerminated();
    await _configureForeground();
    await _configureBackground();
  }

  Future<void> _configureForeground() async {
    if (await _isAuthorized) {
      FirebaseMessaging.onMessage.listen(_messageHandler);
    }
  }

  Future<void> _configureBackground() async {
    if (await _isAuthorized) {
      FirebaseMessaging.onMessageOpenedApp.listen(_messageHandler);
    }
  }

    Future<void> _configureTerminated() async {
    if (await _isAuthorized) {
      RemoteMessage? initialMsg =  await FirebaseMessaging.instance.getInitialMessage();
      _messageHandler(initialMsg);
    }
  }

  Future<bool> get _isAuthorized async {
    final messaging = FirebaseMessaging.instance;
    final setting =  await messaging.requestPermission();

    return setting.authorizationStatus == AuthorizationStatus.authorized;
  }

  void _messageHandler(RemoteMessage? msg) {
    if (msg == null || msg.notification == null) {
      return;
    }

    add(ChatNotification(
        title: msg.notification!.title ?? 'Não informado',
        body: msg.notification!.body ?? 'Não informado'));
  }
}
