import 'package:flutter_riverpod/flutter_riverpod.dart';

final focusedProvider = StateProvider<DateTime>((ref) => DateTime.now());
