import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:our_story/application/state/visible_provider.dart';
import 'package:our_story/presentation/theme/size.dart';

const w = RawSize.w;
const w2 = w * 2;
const w3 = w * 3;
const h = RawSize.h;
const h2 = h * 2;
const h3 = h * 3;

class PrefectureS extends ConsumerWidget {
  final text;
  const PrefectureS({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(visibleProvider.notifier);
    onPress() {
      notifier.state = true;
    }

    return TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        minimumSize: MaterialStateProperty.all(const Size(w, h)),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: MaterialStateProperty.all(Colors.greenAccent),
      ),
      onPressed: onPress,
      child: Text(text),
    );
  }
}

class PrefectureWide extends ConsumerWidget {
  final text;
  const PrefectureWide({super.key, required this.text});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(visibleProvider.notifier);
    onPress() {
      notifier.state = true;
    }

    return TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        minimumSize: MaterialStateProperty.all(const Size(w2, h)),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: MaterialStateProperty.all(Colors.greenAccent),
      ),
      onPressed: onPress, //onPressed,
      child: Text(text),
    );
  }
}

class PrefectureTall extends ConsumerWidget {
  final text;
  const PrefectureTall({super.key, required this.text});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(visibleProvider.notifier);
    onPress() {
      notifier.state = true;
    }

    return TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        minimumSize: MaterialStateProperty.all(const Size(w, h2)),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: MaterialStateProperty.all(Colors.greenAccent),
      ),
      onPressed: onPress, //onPressed,
      child: Text(text),
    );
  }
}

class PrefectureBig extends ConsumerWidget {
  final text;
  const PrefectureBig({super.key, required this.text});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(visibleProvider.notifier);
    onPress() {
      notifier.state = true;
    }

    return TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        minimumSize: MaterialStateProperty.all(const Size(w2, h2)),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: MaterialStateProperty.all(Colors.greenAccent),
      ),
      onPressed: onPress, //onPressed,
      child: Text(text),
    );
  }
}
