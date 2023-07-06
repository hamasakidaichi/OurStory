import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:our_story/domain/features/room_model.dart';

Future<void> updateRoom(Room room) async {
  try {
    print('Updating room: $room'); // デバッグプリント

    // Firestoreのルームデータを更新
    await FirebaseFirestore.instance
        .collection('rooms') // ルートコレクション名を指定
        .doc(room.roomId) // ドキュメントIDを指定
        .update({
      'roomName': room.roomName,
      'creatorId': room.creatorId,
      'participantIds': room.participantIds,
    });
    print('Room updated successfully');
  } catch (e) {
    // エラーハンドリング
    print('Error updating room: $e');
  }
}
