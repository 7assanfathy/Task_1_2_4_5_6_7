import 'package:flutter/material.dart';

class Options extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPressed;
  final Color? color;

  const Options({
    required this.onPressed,
    required this.title,
    required this.icon,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(icon: Icon(icon, color: color), onPressed: onPressed),
        Text(title),
      ],
    );
  }
}