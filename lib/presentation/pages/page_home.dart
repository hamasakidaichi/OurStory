import 'package:flutter/material.dart';
import 'package:our_story/presentation/widgets/menu_card.dart';
import 'package:our_story/presentation/widgets/title_home.dart';

class PageHome extends StatelessWidget {
  const PageHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          HomeTitle(),
          Center(
              child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MenuCard(),
                  MenuCard(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MenuCard(),
                  MenuCard(),
                ],
              ),
            ],
          )),
        ],
      )),
    );
  }
}
