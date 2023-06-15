import 'package:flutter/material.dart';
import 'package:our_story/presentation/theme/L10n.dart';

class MenuCard extends StatelessWidget {
  const MenuCard({
    super.key,
    // required this.onPressed,
  });

  //final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(300, 300),
        ),
        onPressed: null, //onPressed,
        child: const Text(
          L10n.tapGame,
        ),
      ),
    );
  }
}
