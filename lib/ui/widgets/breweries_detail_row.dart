import 'package:flutter/material.dart';
import 'package:optical_character_recognizer/constants/text_styles.dart';

class BreweriesDetailsRow extends StatelessWidget {
  const BreweriesDetailsRow({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(title, style: greyTitleTextStyle),
            Text(subtitle, style: blackTitleTextStyle),
          ],
        ),
      ],
    );
  }
}
