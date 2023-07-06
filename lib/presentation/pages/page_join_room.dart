import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:our_story/application/state/firestore_provider.dart';
import 'package:our_story/application/state/room_name_ctl_provider.dart';
import 'package:our_story/application/state/user_provider.dart';
import 'package:our_story/domain/features/room_model.dart';
import 'package:our_story/domain/types/update_room.dart';

class PageJoinRoom extends ConsumerWidget {
  const PageJoinRoom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roomNameController = ref.watch(roomNameControllerProvider);
    final user = ref.watch(userProvider);
    final firestore = ref.watch(firestoreProvider);

    Future<void> joinRoom() async {
      String roomName = roomNameController.text;
      print('roomName: $roomName'); // デバッグプリント

      // Firestoreでroomsコレクション内のドキュメントを検索
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
          .collection('rooms')
          .where('roomName', isEqualTo: roomName)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
            querySnapshot.docs.first;
        // 一致するルームが存在する場合は参加処理を行う
        Room room = Room.fromMap(documentSnapshot.data()!);
        if (!room.participantIds.contains(user.uid)) {
          // 重複をチェックしてから追加する
          room.participantIds.add(user.uid);
          print('Before update: ${room.participantIds}');
          updateRoom(room);

          print('After update: ${room.participantIds}');

          // ルーム情報を更新する
          // ルーム参加後の処理を追加する場合はここに記述
        } else {
          // すでに参加者として登録済みの場合はエラーメッセージを表示
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Error'),
              content: const Text('すでに参加済みです'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }

        // ルーム情報を更新する
        // ルーム参加後の処理を追加する場合はここに記述
      } else {
        // 一致するルームが存在しない場合はエラーメッセージを表示
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Error'),
            content: const Text('ルーム名が違います'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }

      roomNameController.clear();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Join Room'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: roomNameController,
              decoration: const InputDecoration(
                labelText: 'Room Name',
              ),
            ),
            ElevatedButton(
              onPressed: joinRoom,
              child: const Text('Join Room'),
            ),
          ],
        ),
      ),
    );
  }
}
