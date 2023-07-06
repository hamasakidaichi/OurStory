import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessagesNotifier extends ChangeNotifier {
  final List<types.Message> _messages = [];
  List<types.Message> get messages => _messages;

  void addMessage(types.Message message) {
    _messages.insert(0, message);
    notifyListeners();
  }
}

final messagesProvider = ChangeNotifierProvider((ref) => MessagesNotifier());

//チャットメッセージの状態管理