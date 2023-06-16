import 'package:flutter/material.dart';

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
          fixedSize: const Size(150, 150),
        ),
        onPressed: null, //onPressed,
        child: const Text(
          'l10n.tapGame',
        ),
      ),
    );
  }
}
