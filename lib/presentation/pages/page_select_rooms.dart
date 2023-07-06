import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:our_story/application/state/select_room_provider.dart';
import 'package:our_story/application/state/user_provider.dart';

class PageSelectRoom extends ConsumerWidget {
  const PageSelectRoom({Key? key}) : super(key: key);

  pushHome(BuildContext context) {
    context.push('/home');
  }

  pushJoin(BuildContext context) {
    context.push('/join');
  }

  pushCreate(BuildContext context) {
    context.push('/create');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.watch(userProvider).uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Room List'),
      ),
      body: Stack(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collectionGroup('rooms').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text('No rooms found.'),
                );
              }

              final rooms = snapshot.data!.docs.where((room) {
                final participantIds = room['participantIds'] as List<dynamic>;
                return participantIds.contains(uid);
              }).toList();

              return ListView.builder(
                itemCount: rooms.length,
                itemBuilder: (context, index) {
                  var room = rooms[index];

                  return ListTile(
                    title: Text(room['roomName']),
                    onTap: () {
                      ref.read(selectedRoomProvider.notifier).updateRooms(
                        [room['roomName'] as String, room['roomId'] as String],
                      );

                      pushHome(context);
                      // ルームに参加する処理を実装
                      // タップされたルームの情報を利用して遷移などを行う
                    },
                  );
                },
              );
            },
          ),
          Positioned(
            left: 16,
            bottom: 16,
            child: FloatingActionButton.extended(
              backgroundColor: Colors.deepOrangeAccent,
              tooltip: 'Action!',
              icon: const Icon(Icons.switch_access_shortcut_add_outlined),
              label: const Text('Join'),
              onPressed: () {
                pushJoin(context);
              },
            ),
          ),
          Positioned(
            right: 16,
            bottom: 16,
            child: FloatingActionButton.extended(
              backgroundColor: const Color.fromARGB(255, 168, 106, 83),
              tooltip: 'Action!',
              icon: const Icon(Icons.add),
              label: const Text('Add'),
              onPressed: () {
                pushCreate(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
