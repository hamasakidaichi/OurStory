import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:our_story/domain/features/room_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final roomProvider =
    StateNotifierProvider<RoomNotifier, Room>((ref) => RoomNotifier());

final myRoomsProvider = FutureProvider<List<Room>>((ref) async {
  String userId = 'your_user_id'; // Replace with your user ID retrieval method
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('rooms')
      .where('participantIds', arrayContains: userId)
      .get();

  return snapshot.docs.map((doc) {
    return Room(
      roomId: doc.id,
      roomName: doc['roomName'],
      creatorId: doc['creatorId'],
      participantIds: List<String>.from(doc['participantIds']),
    );
  }).toList();
});

class RoomNotifier extends StateNotifier<Room> {
  RoomNotifier()
      : super(
            Room(roomId: '', roomName: '', creatorId: '', participantIds: []));

  void updateRoomName(String newRoomName) {
    state = state.copyWith(roomName: newRoomName);
  }

  void createRoom() {
    // ルーム作成の処理を追加する
  }

  void deleteRoom(String roomId) {
    // ルーム削除の処理を追加する
  }
}

class PageCreateRoom extends ConsumerWidget {
  final TextEditingController _roomNameController = TextEditingController();

  PageCreateRoom({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final room = ref.watch(roomProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Room'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _roomNameController,
            decoration: const InputDecoration(
              labelText: 'Room Name',
            ),
            onChanged: (value) {
              room.updateRoomName(value);
            },
          ),
          ElevatedButton(
            onPressed: () {
              room.createRoom();
              _roomNameController.clear();
            },
            child: const Text('Create'),
          ),
          ref.watch(myRoomsProvider).when(
                data: (rooms) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: rooms.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: Key(rooms[index].roomId),
                          direction: DismissDirection.startToEnd,
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerLeft,
                            child: const Icon(Icons.delete),
                          ),
                          onDismissed: (direction) {
                            room.deleteRoom(rooms[index].roomId);
                          },
                          child: ListTile(
                            title: Text(rooms[index].roomName),
                            subtitle:
                                Text('Creator: ${rooms[index].creatorId}'),
                          ),
                        );
                      },
                    ),
                  );
                },
                loading: () => const CircularProgressIndicator(),
                error: (error, stackTrace) => Text('Error: $error'),
              ),
        ],
      ),
    );
  }
}
