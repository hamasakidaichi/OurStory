import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:our_story/application/state/firestore_provider.dart';
import 'package:our_story/application/state/room_name_ctl_provider.dart';
import 'package:our_story/application/state/user_provider.dart';

class PageCreateRoom extends ConsumerWidget {
  const PageCreateRoom({Key? key}) : super(key: key);
  pushJoin(BuildContext context) {
    context.push('/join');
  }

  Future<void> createSubcollections(
      String roomId, FirebaseFirestore firestore) async {
    await firestore
        .collection('rooms')
        .doc(roomId)
        .collection('chat')
        .doc()
        .set({
      'message': 'Welcome to the chat room!',
    });
    await firestore
        .collection('rooms')
        .doc(roomId)
        .collection('map')
        .doc()
        .set({
      'location': 'Initial location',
    });
    await firestore
        .collection('rooms')
        .doc(roomId)
        .collection('cal')
        .doc()
        .set({
      'event': 'Initial event',
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roomNameController = ref.watch(roomNameControllerProvider);
    final user = ref.watch(userProvider);
    final firestore = ref.watch(firestoreProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Room'),
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
              onPressed: () async {
                String roomName = roomNameController.text;

                // ルーム名の一意性を確認
                QuerySnapshot<Map<String, dynamic>> querySnapshot =
                    await firestore
                        .collection('rooms')
                        .where('roomName', isEqualTo: roomName)
                        .limit(1)
                        .get();
                if (querySnapshot.docs.isNotEmpty) {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Error'),
                      content: const Text('そのルーム名は既に使用されています'),
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
                  return;
                }

                // 一意であればルームを作成

                DocumentReference<Map<String, dynamic>> docRef =
                    firestore.collection('rooms').doc();
                String roomId = docRef.id;

                await docRef.set({
                  'roomName': roomName,
                  'roomId': roomId,
                  'creatorId': user.uid,
                  'participantIds': [user.uid],
                });

                // サブコレクションを作成
                await createSubcollections(roomId, firestore);

                roomNameController.clear();
              },
              child: const Text('Create Room'),
            ),
          ],
        ),
      ),
    );
  }
}
