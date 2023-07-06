import 'package:flutter_riverpod/flutter_riverpod.dart';

final eventListsProvider = StateProvider<List>((ref) => []);

//カレンダーのイベントリストのデータモデル