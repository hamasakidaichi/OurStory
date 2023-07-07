import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:our_story/application/state/select_room_provider.dart';
import 'package:our_story/application/state/user_provider.dart';
import 'package:our_story/presentation/pages/page_select_rooms.dart';
import '../../domain/types/utils.dart';

class MessagesNotifier extends ChangeNotifier {
  final List<types.Message> _messages = [];
  List<types.Message> get messages => _messages;
  final Stream<List<types.Message>> _messagesStream;

  MessagesNotifier(String roomId)
      : _messagesStream = getMessagesStream(roomId) {
    startListening();
  }
  void startListening() {
    _messagesStream.listen((List<types.Message> receivedMessages) {
      if (receivedMessages.isNotEmpty) {
        _messages.clear();
        _messages.addAll(receivedMessages);
        notifyListeners();
      }
    });
  }

  void addMessage(types.Message message) {
    _messages.insert(0, message);
    debugPrint('Added message: $message');
    notifyListeners();
  }
}

final messagesProvider =
    ChangeNotifierProvider((ref) => MessagesNotifier(selectedRoomId));

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

Stream<List<types.Message>> getMessagesStream(String roomId) {
  final collectionRef = FirebaseFirestore.instance
      .collection('rooms')
      .doc(roomId)
      .collection('chat');

  return collectionRef
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((querySnapshot) => querySnapshot.docs.map((doc) {
            final data = doc.data();
            final message = types.TextMessage(
              id: data['id'] as String,
              text: data['text'] as String,
              author:
                  types.User.fromJson(data['author'] as Map<String, dynamic>),
              createdAt: data['createdAt'] as int,
            );
            return message;
          }).toList());
}

class PageChat extends ConsumerWidget {
  const PageChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.read(userProvider).uid;
    final user = types.User(id: userId);
    final selectedRoom = ref.read(selectedRoomProvider);
    final roomId = selectedRoom[1];

    final messages = ref.watch(messagesProvider);

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
