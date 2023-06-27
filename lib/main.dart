import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:our_story/infrastructure/firebase/firebase_options.dart';
import 'package:our_story/presentation/router/app.dart';

final visibleProvider = StateProvider((ref) {
  return false;
});

final focusedProvider = StateProvider<DateTime>((ref) => DateTime.now());
final selectedProvider = StateProvider<DateTime?>((ref) => null);
final eventListsProvider = StateProvider<List>((ref) => []);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  const scope = ProviderScope(child: MyApp());
  initializeDateFormatting().then((_) => runApp(scope));
}
