import 'package:flutter/material.dart';

class MenuCard extends StatelessWidget {
  final text;
  final onPressed;
  const MenuCard({
    super.key,
    required this.text,
    required this.onPressed,
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
        onPressed: onPressed, //onPressed,
        child: Text(text),
      ),
    );
  }
}
