import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:our_story/application/state/select_room_provider.dart';
import 'package:our_story/presentation/theme/L10n.dart';
import 'package:our_story/presentation/widgets/menu_card.dart';
import 'package:our_story/presentation/widgets/title_home.dart';

class PageHome extends ConsumerWidget {
  const PageHome({super.key});

  pushMap(BuildContext context) {
    context.push('/map');
  }

  pushCalendar(BuildContext context) {
    context.push('/calendar');
  }

  pushChat(
    BuildContext context,
  ) {
    context.push('/chat');
  }

  pushCreate(BuildContext context) {
    context.push('/create');
  }

  goSelection(BuildContext context) {
    context.go('/selection');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //ドキュメントパス

    final selectedRoom = ref.read(selectedRoomProvider);
    final roomName = selectedRoom[0];

    // selectedRoomの内容をデバッグプリントで表示
    print('selectedRoom: $selectedRoom');

    return Scaffold(
      appBar: AppBar(
        title: Text(roomName),
        leading: IconButton(
            onPressed: () => goSelection(context),
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const HomeTitle(),
          Center(
              child: Column(
            children: [
              ElevatedButton(
                onPressed: () => pushCreate(context),
                child: const Text('create'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const MenuCard(text: L10n.ourTap, onPressed: null),
                  MenuCard(
                    text: L10n.ourMap,
                    onPressed: () => pushMap(context),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MenuCard(
                    text: L10n.ourCal,
                    onPressed: () => pushCalendar(context),
                  ),
                  MenuCard(
                    text: L10n.ourChat,
                    onPressed: () => pushChat(context),
                  ),
                ],
              ),
            ],
          )),
        ],
      )),
    );
  }
}
