import 'package:flutter/material.dart';
import 'package:our_story/presentation/widgets/map_block.dart';

class MapOfJp extends StatelessWidget {
  const MapOfJp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
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
    );
  }
}
