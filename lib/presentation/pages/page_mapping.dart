import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:our_story/application/state/visible_provider.dart';
import 'package:our_story/presentation/widgets/cover.dart';
import 'package:our_story/presentation/widgets/map_block.dart';

class PageMapping extends ConsumerWidget {
  const PageMapping({super.key});

  backHome(BuildContext context) {
    context.pop('/home');
  }

//const Icon(Icons.arrow_back),
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visible = ref.watch(visibleProvider);
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            child: const Icon(Icons.arrow_back),
            onTap: () => backHome(context),
          ),
        ),
        body: Stack(
          children: [
            const Center(
              child: SizedBox(
                height: 500,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    block1(),
                    block2(),
                    block3(),
                    block4(),
                    block5(),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: visible,
              child: const Cover(),
            )
          ],
        ));
  }
}
