import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:our_story/infrastructure/firebase/firebase_options.dart';
import 'package:our_story/presentation/router/app.dart';

final visibleProvider = StateProvider((ref) {
  return false;
});

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  const scope = ProviderScope(child: MyApp());
  runApp(scope);
}
