import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:our_story/domain/features/room_model.dart';

Stream<List<Room>> getRooms() {
  return FirebaseFirestore.instance
      .collection('rooms')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => Room(
                roomId: doc.id,
                roomName: doc['roomName'],
                creatorId: doc['creatorId'],
                participantIds: List<String>.from(doc['participantIds']),
              ))
          .toList());
}
