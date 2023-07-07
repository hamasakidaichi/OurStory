import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:our_story/application/state/message_provider.dart';
import 'package:our_story/application/state/select_room_provider.dart';
import 'package:our_story/application/state/user_provider.dart';
import '../../domain/types/utils.dart';

Future<void> sendMessage(String roomId, types.User user, String text) async {
  final collectionRef = FirebaseFirestore.instance
      .collection('rooms')
      .doc(roomId)
      .collection('chat');

  final message = types.TextMessage(
    author: user,
    createdAt: DateTime.now().millisecondsSinceEpoch,
    id: randomString(),
    text: text,
  );

  await collectionRef.add({
    'author': message.author.toJson(),
    'createdAt': message.createdAt,
    'id': message.id,
    'text': message.text,
  });
}

class PageChat extends ConsumerWidget {
  const PageChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messages = ref.watch(messagesProvider);
    final userId = ref.watch(userProvider).uid;
    final user = types.User(id: userId);
    final selectedRoom = ref.read(selectedRoomProvider);
    final roomId = selectedRoom[1];

    void handleSendPressed(types.PartialText message) {
      final textMessage = types.TextMessage(
        author: user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: randomString(),
        text: message.text,
      );

      sendMessage(roomId, user, message.text); // メッセージをFirestoreに送信
      ref.read(messagesProvider).addMessage(textMessage);
    }

    void backHome(BuildContext context) {
      context.pop('/home');
    }

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back),
          onTap: () => backHome(context),
        ),
      ),
      body: Chat(
        messages: messages.messages,
        onSendPressed: handleSendPressed,
        user: user,
      ),
    );
  }
}
