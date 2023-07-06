import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = Provider<User>((ref) {
  return FirebaseAuth.instance.currentUser!;
});
//page_create_room.dart 現在サインインしているユーザーのUserオブジェクトを返す　