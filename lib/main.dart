import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:our_story/infrastructure/firebase/firebase_options.dart';
import 'package:our_story/presentation/router/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}
