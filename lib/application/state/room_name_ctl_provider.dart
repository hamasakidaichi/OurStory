import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final roomNameControllerProvider = Provider<TextEditingController>((ref) {
  return TextEditingController();
});

//TextEditingControllerのインスタンス化　ルーム作成のroomNameフォームの状態管理