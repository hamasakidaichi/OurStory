import 'package:flutter_riverpod/flutter_riverpod.dart';

final visibleProvider = StateProvider((ref) {
  return false;
});

//マップでボタンイベントによりcoverを表示するかの条件