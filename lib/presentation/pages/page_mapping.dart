import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:our_story/presentation/widgets/map_jp.dart';

class PageMapping extends StatelessWidget {
  const PageMapping({super.key});

  backHome(BuildContext context) {
    context.pop('/home');
  }

//const Icon(Icons.arrow_back),
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            child: const Icon(Icons.arrow_back),
            onTap: () => backHome(context),
          ),
        ),
        body: const Stack(
          children: [
            MapOfJp(),
          ],
        ));
  }
}
