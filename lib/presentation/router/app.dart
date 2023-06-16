import 'package:flutter/material.dart';
import '../pages/page_home.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PageHome(),
    );
  }
}
