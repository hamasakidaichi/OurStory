import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:our_story/domain/features/room_model.dart';

Future<void> createRoom(Room room) async {
  await FirebaseFirestore.instance.collection('rooms').doc(room.roomId).set({
    'roomName': room.roomName,
    'creatorId': room.creatorId,
    'participantIds': room.participantIds,
  }).then((value) {
    debugPrint('Room created successfully!');
    debugPrint('Room ID: ${room.roomId}');
    debugPrint('Room Name: ${room.roomName}');
    debugPrint('Creator ID: ${room.creatorId}');
    debugPrint('Participant IDs: ${room.participantIds}');
  }).catchError((error) {
    debugPrint('Error creating room: $error');
  });
}
// createRoomはfirestoreにコレクションを追加するメソッドであり、引数としてRoomクラスのインスタンスを受け取りroom変数に格納
// collection('rooms')でFirestore内に新しいコレクションを作成 コレクションの名前は「rooms」
// doc(room.roomId)は、作成したRoomオブジェクトのroomIdをドキュメントIDとして指定 これにより、各ルームは一意のドキュメントIDを持つ
// set({...})は、指定したドキュメントにデータを保存するためのメソッド。引数には保存するデータをマップ形式で指定。
//'roomName': room.roomNameはルームの名前、'creatorId': room.creatorIdはルーム作成者のID、'participantIds': room.participantIdsはルームに参加しているユーザーのIDの一覧


