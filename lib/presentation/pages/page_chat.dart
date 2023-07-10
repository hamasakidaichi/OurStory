import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:our_story/application/state/select_room_provider.dart';
import 'package:our_story/application/state/user_provider.dart';
import 'package:our_story/domain/types/roomid_holder.dart';
import '../../domain/types/utils.dart';

//MessagesNotifierはChangeNotifierを継承しており、
//状態の変更をリスナーに通知する役目を持っている
//ここでの状態の変更とは、メッセージのことである
//_messagesプロパティは、メッセージ自体を格納するためのリストであり、
//外部から参照できるようにしたもの
//_messagesStreamプロパティは、Firestoreのメッセージストリームを取得する
//startListeningメソッドで、_messageStreamを購読し、新しいメッセージがFirestore
//に届いた際に、_messagesリストを更新し、リスナーに通知する。
//この場合のリスナーとは、MessagesNotifierのインスタンスを監視しているウィジェットなど
//通知させたいリスナーは実装や要件により変化する
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

//addMesageメソッドは、新しいメッセージを_messagesに加え、リスナーに通知する。
  void addMessage(types.Message message) {
    _messages.insert(0, message);
    debugPrint('Added message: $message');
    notifyListeners();
  }
}

//messagesProviderはChangeNotifierProviderであり、MessagesNotifierのインスタンスである
//roomIdを使用して、MessagesNotifierを初期化する。
//ここで使われるroomIdはユーザーが作成したルームコレクション直下のドキュメントIdであり、
//これを渡すことでgetMessagesStreamは正しい参照先を得る
final messagesProvider =
    ChangeNotifierProvider((ref) => MessagesNotifier(RoomIdHolder.roomId));

//sendMessageは指定されたルームIdのメッセージストリームを取得するための関数である
//awaitで送ったメッセージをコレクション内のドキュメントに追加する処理が完了するまで待つ

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

//getMessagesStream関数は、指定されたルームIdのメッセージストリームを取得する
//二つの型、<List<types.Message>>とgetMessagesStreamが持つStream<List<types.Message>>
//を持つ。
//Firestoreからのストリームを受け取り、
//List<types.Message> 型のリストとしてマッピングして返すため
//その戻り値の型は List<types.Message> となる
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

//ここでMessagesNotifierのインスタンスが生成され、そのインスタンスが監視される
//具体的な処理は、_messagesリストが更新されるとnofifyListenersが呼ばれ、
//PageChatへ通知する。これにより新しいメッセージが発信されるたびに、ウィジェットが再構築される
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
