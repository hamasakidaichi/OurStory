import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:our_story/application/state/message_provider.dart';
import '../../domain/types/utils.dart';

class PageChat extends ConsumerWidget {
  const PageChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messages = ref.watch(messagesProvider);
    const user = types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3ac');

    void handleSendPressed(types.PartialText message) {
      final textMessage = types.TextMessage(
        author: user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: randomString(),
        text: message.text,
      );

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
