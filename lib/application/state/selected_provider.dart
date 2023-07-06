import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedProvider = StateProvider<DateTime?>((ref) => null);

//カレンダーの現在選択中の日付