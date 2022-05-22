import 'package:flutter/material.dart';

import '../models/letter.dart';
import 'letter_box.dart';

class TextRow extends StatelessWidget {
  TextRow({Key? key, required this.text}) : super(key: key);
  final List<Letter> text;
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int index = 0; index < text.length; index++)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            child: LetterBox(
              letter: text[index],
            ),
          )
      ],
    );
  }
}
