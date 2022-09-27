import 'package:flutter/material.dart';

class CustomRow extends StatelessWidget {
  const CustomRow({
    Key? key,
    required this.icon,
    required this.text,
    required this.onPress,
    required this.color,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final VoidCallback onPress;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.black),
            const SizedBox(width: 5),
            GestureDetector(
              onTap: onPress,
              child: Container(
                height: 40,
                width: 120,
                decoration: BoxDecoration(
                  color: color,
                ),
                alignment: Alignment.center,
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
