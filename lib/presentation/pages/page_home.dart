import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:our_story/presentation/theme/L10n.dart';
import 'package:our_story/presentation/widgets/menu_card.dart';
import 'package:our_story/presentation/widgets/title_home.dart';

class PageHome extends StatelessWidget {
  const PageHome({super.key});

  pushMap(BuildContext context) {
    context.push('/map');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const HomeTitle(),
          Center(
              child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const MenuCard(text: L10n.tapGame, onPressed: null),
                  MenuCard(
                    text: L10n.yet,
                    onPressed: () => pushMap(context),
                  ),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MenuCard(text: L10n.yet, onPressed: null),
                  MenuCard(text: L10n.yet, onPressed: null),
                ],
              ),
            ],
          )),
        ],
      )),
    );
  }
}
