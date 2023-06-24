import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:our_story/main.dart';

class Cover extends ConsumerWidget {
  const Cover({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(visibleProvider.notifier);
    onPress() {
      notifier.state = false;
    }

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.black87,
      child: Column(
        children: [
          Container(
            color: Colors.amberAccent,
            width: 150,
            height: 150,
            child: const Text('aaaa'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(fixedSize: const Size(30, 30)),
            onPressed: onPress,
            child: const Text('戻る'),
          ),
        ],
      ),
    );
  }
}
